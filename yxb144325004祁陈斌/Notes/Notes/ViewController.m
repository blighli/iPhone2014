//
//  ViewController.m
//  Notes
//
//  Created by xsdlr on 14/11/17.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "ViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Note.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    Note* note = [Note MR_createEntity];
//    note.message = @"test";
//    note.time = [NSDate new];
//    note.type = @"text";
//    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    
    _notes = [[NSMutableArray alloc] initWithArray:[Note MR_findAllSortedBy:@"time" ascending:NO]];
//    NSLog(@"%ld",_notes.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:CellIdentifier];
    }
    Note* note = self.notes[indexPath.row];
    NSString* type = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    if ([note.type isEqualToString:Note.TEXT_TYPE]) {
        type = @"文本";
    } else if ([note.type isEqualToString:Note.IMAGE_TYPE]) {
        type = @"照片";
    } else if ([note.type isEqualToString:Note.DRAW_TYPE]) {
        type = @"手绘";
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

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Note* note = [self.notes objectAtIndex:[indexPath row]];
    if ([note.type isEqualToString:Note.TEXT_TYPE]) {
        [self performSegueWithIdentifier:@"textSegue" sender:[NSNumber numberWithInteger:indexPath.row]];
    } else if ([note.type isEqualToString:Note.IMAGE_TYPE]) {
        [self performSegueWithIdentifier:@"imageSegue" sender:[NSNumber numberWithInteger:indexPath.row]];
    } else if ([note.type isEqualToString:Note.DRAW_TYPE]) {
        [self performSegueWithIdentifier:@"imageSegue" sender:[NSNumber numberWithInteger:indexPath.row]];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"类型不支持" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destination = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"textSegue"]) {
        [destination setValue:sender forKeyPath:@"noteIndex"];
    } else if ([segue.identifier isEqualToString:@"imageSegue"]) {
        [destination setValue:sender forKeyPath:@"noteIndex"];
    } else {
        [destination setValue:nil forKeyPath:@"noteIndex"];
    }
    [destination setValue:self forKeyPath:@"delegate"];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note* note = [self.notes objectAtIndex:[indexPath row]];
        [self.notes removeObjectAtIndex:[indexPath row]];
        [note MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (IBAction)takePhoto:(UIBarButtonItem *)sender {
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
        Note* note = [Note MR_createEntity];
        note.time = nowDate;
        note.message = imageFilePath;
        note.type = Note.IMAGE_TYPE;
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        [self.notes insertObject:note atIndex:0];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"图片保存失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
