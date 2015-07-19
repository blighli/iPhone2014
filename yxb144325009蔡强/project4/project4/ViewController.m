//
//  ViewController.m
//  project4
//
//  Created by zack on 14-11-22.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _context = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
    //创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note"inManagedObjectContext:_context];
    //设置请求实体
    [request setEntity:entity];
    NSError *error = nil;
    //执行获取数据请求，返回数组
    NSMutableArray *mutableFetchResult = [[_context executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"获取数据失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    _notesArray = mutableFetchResult;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_notesTableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destination = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"showDetail"]){
        [destination setValue:_notesArray forKeyPath:@"notesArray"];
        [destination setValue:[_notesTableView indexPathForCell:sender] forKeyPath:@"indexPath"];
    } else {
        [destination setValue:self forKeyPath:@"delegate"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return _notesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    Note* note = _notesArray[indexPath.row];
    cell.textLabel.text = note.type;
    cell.detailTextLabel.text = note.time;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note* note = [_notesArray objectAtIndex:[indexPath row]];
        [_context deleteObject:note];
        NSError *error;
        if ([_context save:&error]) {
            [_notesArray removeObject:note];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
            NSLog(@"删除成功！");
        } else {
            [[[UIAlertView alloc] initWithTitle:@"错误" message:@"删除失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
            NSLog(@"Error:%@,%@",error,[error userInfo]);
        }
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"设备不支持拍照" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
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
    if ([imageData writeToFile:imageFilePath atomically:YES] ) {
        Note *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:_context];
        note.content = imageFilePath;
        note.type = @"照片";
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
        NSDate* nowDate = [NSDate new];
        note.time = [dateFormatter stringFromDate: nowDate];
        NSError *error = nil;
        if ([_context save:&error]) {
            [_notesArray addObject:note];
            NSLog(@"保存成功");
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"错误" message:@"保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
            NSLog(@"error:%@,%@",error,[error userInfo]);
        }
        
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
