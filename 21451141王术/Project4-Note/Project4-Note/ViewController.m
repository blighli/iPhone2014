//
//  ViewController.m
//  Project4-Note
//
//  Created by  ws on 11/20/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import "ViewController.h"
#import "Data.h"
@interface ViewController ()
@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Start the location manager.
    [[self locationManager] startUpdatingLocation];
    
    /*
     Fetch existing events.
     Create a fetch request, add a sort descriptor, then execute the fetch.
     */
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Data" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    // Order the events by creation date, most recent first.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    
    // Execute the fetch -- create a mutable copy of the result.
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
    }
    
    // Set self's events array to the mutable array, then clean up.
    [self setMynotes:mutableFetchResults];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//列表行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.mynotes count];
}
//列表内容
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil) {
    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    Data* note = self.mynotes[indexPath.row];
    NSString* type = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    if ([note.type isEqualToString:Data.TEXT_TYPE]) {
        type = @"文本";
    } else if ([note.type isEqualToString:Data.IMAGE_TYPE]) {
        type = @"拍摄照片";
    } else if ([note.type isEqualToString:Data.DRAW_TYPE]) {
        type = @"手写草稿";
    } else {
        type = @"未定义";
    }
    cell.textLabel.text = type;
    cell.detailTextLabel.text = [dateFormatter stringFromDate: note.time];

    return cell;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
//选择列表单元
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Data* note = [self.mynotes objectAtIndex:[indexPath row]];
    if ([note.type isEqualToString:Data.TEXT_TYPE]) {
        [self performSegueWithIdentifier:@"textSegue2" sender:[NSNumber numberWithInteger:indexPath.row]];
    } else if ([note.type isEqualToString:Data.IMAGE_TYPE]) {
        [self performSegueWithIdentifier:@"imageSegue" sender:[NSNumber numberWithInteger:indexPath.row]];
    } else if ([note.type isEqualToString:Data.DRAW_TYPE]) {
        [self performSegueWithIdentifier:@"imageSegue" sender:[NSNumber numberWithInteger:indexPath.row]];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"类型不支持" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }
    
}
//传递数值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destination = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"textSegue"]) {
        
    } else if ([segue.identifier isEqualToString:@"textSegue2"]) {
        [destination setValue:sender forKeyPath:@"noteIndex"];
        
    } else if ([segue.identifier isEqualToString:@"imageSegue"]) {
     [destination setValue:sender forKeyPath:@"noteIndex"];
    }else {
        [destination setValue:nil forKeyPath:@"noteIndex"];
    }
    [destination setValue:self.managedObjectContext forKey:@"managedObjectContext"];
    [destination setValue:self forKeyPath:@"delegate"];
}
//添加删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *eventToDelete = (self.mynotes)[indexPath.row];
        //从上下文中删除
        [self.managedObjectContext deleteObject:eventToDelete];
        [self.mynotes removeObjectAtIndex:[indexPath row]];

        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除？";
}

#pragma mark - Location manager

/**
 Return a location manager -- create one if necessary.
 */
- (CLLocationManager *)locationManager
{
    if (_locationManager != nil) {
        return _locationManager;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager setDelegate:self];
    
    return _locationManager;
}
- (IBAction)photo:(UIButton *)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"不支持拍照" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString* imageDirPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString: @"/images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:imageDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyyMMddHHmmss"];
    
    NSDate* nowDate = [NSDate new];
    NSString *imageFilePath = [imageDirPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate: nowDate], @"jpg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    //插入成功
    if ([imageData writeToFile:imageFilePath atomically:YES] ) {
        //声明新的Data变量
        Data* note= (Data *)[NSEntityDescription insertNewObjectForEntityForName:@"Data" inManagedObjectContext:self.managedObjectContext];
        note.time = nowDate;
        note.attribute = imageFilePath;
        note.type = Data.IMAGE_TYPE;
        //数据储存
        NSError *error = nil;
        if (![note.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [self.mynotes insertObject:note atIndex:0];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"图片保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


/**
 Conditionally enable the Add button:
 If the location manager is generating updates, then enable the button;
 If the location manager is failing, then disable the button.
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //self.addButton.enabled = YES;
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
#ifdef DEBUG
    NSLog(@"Location manager failed");
#else
    self.addButton.enabled = NO;
#endif
}
@end
