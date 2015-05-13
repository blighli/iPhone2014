//
//  PicNoteViewController.m
//  MyNotes
//
//  Created by alwaysking on 14/11/24.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import "PicNoteViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ViewController.h"
#import "AppDelegate.h"
#import "PictureNote.h"

@interface PicNoteViewController ()

@end

@implementation PicNoteViewController

@synthesize imageview;
@synthesize picker;
@synthesize imageNameStr;
@synthesize managedObjectContext;
@synthesize picFetchRequest;
@synthesize textField,btnSoot;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentModalViewController:picker animated:YES];//进入照相界面
    
}

-(void)viewWillAppear:(BOOL)animated
{
    PictureNote *note;
    if (tableItemClick) {
        note = [picNoteArray objectAtIndex:[picNoteArray count] - tableDataRow - 1];
        textField.text = [NSString stringWithFormat:@"%@",note.name];
        [btnSoot setHidden:YES];
        NSString *picDirectory = [self documentsPathForFileName:nil];
        NSString *picPath = [picDirectory stringByAppendingPathComponent:note.picRoot];
        NSData *pngData = [NSData dataWithContentsOfFile:picPath];
        NSLog(note.picRoot);
        UIImage *image = [UIImage imageWithData:pngData];
        imageview.image = image;
    }
    else{
        [btnSoot setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCancle:(id)sender{
    tableItemClick = false;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnOk:(id)sender{
    
    
    if (imageview.image != nil) {
        if (tableItemClick) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            NSError * error;
            self.managedObjectContext = [appDelegate managedObjectContext];
            
            picFetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"PictureNote"
                                                      inManagedObjectContext:self.managedObjectContext];
            [picFetchRequest setEntity:entity];
            NSMutableArray *noteArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:picFetchRequest error:nil]];
            PictureNote *note = (PictureNote *)[noteArray objectAtIndex:[picNoteArray count] - tableDataRow - 1];
            [note setValue:textField.text forKey:@"name"];
            if (![note.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
        }else{
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            self.managedObjectContext = [appDelegate managedObjectContext];
            
            PictureNote * picNote = [NSEntityDescription insertNewObjectForEntityForName:@"PictureNote"
                                                                  inManagedObjectContext:self.managedObjectContext];
            picNote.tagId = [NSString stringWithFormat:@"%lu",[picNoteArray count]];
            if (![textField.text isEqual:@""]) {
                picNote.name = textField.text;
            }else{
                picNote.name = [NSString stringWithFormat:@"Picture%@",picNote.tagId];
            }
            imageNameStr = [NSString stringWithFormat:@"Image%@.png",picNote.tagId];
            picNote.picRoot = imageNameStr;
            NSLog(picNote.picRoot);
            picFetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"PictureNote"
                                                      inManagedObjectContext:self.managedObjectContext];
            
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            [picFetchRequest setEntity:entity];
            
            NSMutableArray *noteArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:picFetchRequest error:&error]];
            [picNoteArray addObject:[noteArray objectAtIndex:[noteArray count] - 1]];
            
            NSData *pngData = UIImagePNGRepresentation(imageview.image);
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *picDirectory = [self documentsPathForFileName:nil];
            // 创建目录
            if (![fileManager fileExistsAtPath:picDirectory]) {
                [fileManager createDirectoryAtPath:picDirectory withIntermediateDirectories:YES attributes:nil error:nil];
            }
            NSString *picPath = [picDirectory stringByAppendingPathComponent:imageNameStr];
            [fileManager createFileAtPath:picPath contents:pngData attributes:nil];
        }
    }
    tableItemClick = false;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//获得文件路径
- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory%@",documentsDirectory);
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"picture"];
    return testDirectory;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage :(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    imageview.image = image;
    [picker dismissModalViewControllerAnimated:YES];
    
    
}

- (IBAction)reShoot:(id)sender{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
