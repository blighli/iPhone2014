//
//  MainViewController.m
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/15.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "MainViewController.h"
#import "NoteEntity.h"
#import "NoteDAO.h"
#import "NoteTableViewCell.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    NoteDAO* _noteDAO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _noteDAO = [NoteDAO new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.noteTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_noteDAO getAllCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NoteListCell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) // 回收双端队列中没有元素，新建元素
        cell = [[NoteTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    NoteEntity *note = [_noteDAO loadNoteByOffset:indexPath.row];
    if(note.type == WordNote) {
        cell.textLabel.text = note.content;
    }
    else if(note.type == PicNote) {
        cell.textLabel.text = @"[图片]";
    }
    else {
        cell.textLabel.text = note.content;
    }
    [cell setValue:note forKey:@"noteEntity"];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NoteEntity* note = [[tableView cellForRowAtIndexPath:indexPath] valueForKey:@"noteEntity"];
        [_noteDAO deleteNoteById:note.id];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteEntity *note = [[tableView cellForRowAtIndexPath:indexPath] valueForKey:@"noteEntity"];
    if(note.type == WordNote) {
        [self performSegueWithIdentifier:@"noteDetailSegue" sender:note];
    }
    else if(note.type == PicNote) {
        [self performSegueWithIdentifier:@"picNoteDetailSegue" sender:note];
    }
    else if(note.type == DrawNote) {
        [self performSegueWithIdentifier:@"drawNoteDetailSegue" sender:note];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destination = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"noteDetailSegue"] || [segue.identifier isEqualToString:@"picNoteDetailSegue"] || [segue.identifier isEqualToString:@"drawNoteDetailSegue"])
        [destination setValue:sender forKeyPath:@"noteEntity"];
}



- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.delegate = self;
        picker.allowsEditing = YES;
    }
    
    [self presentViewController:picker animated:YES completion:^{NSLog(@"hello");}];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"doc path is %@", docPath);
        NSString *imagePath = [docPath stringByAppendingPathComponent:@"image"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss_SSSS"];
        NSDate* nowDate = [[NSDate alloc] init];
        NSString *imageFilePath = [imagePath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate:nowDate], @"jpg"];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        if([imageData writeToFile:imageFilePath atomically:YES]) {
            NSLog(@"image write to file success, file is %@", imageFilePath);
            NoteEntity *note = [[NoteEntity alloc] initWithType:PicNote andContent:imageFilePath];
            [_noteDAO insertNote:note];
        }
        else {
            NSLog(@"image wiret to file failed, file is %@", imageFilePath);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
