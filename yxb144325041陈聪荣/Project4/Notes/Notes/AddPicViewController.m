//
//  AddPicViewController.m
//  Notes
//
//  Created by 陈聪荣 on 14/12/6.
//  Copyright (c) 2014年 zju. All rights reserved.
//
#import "NoteBiz.h"
#import "AddPicViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation AddPicViewController

- (void)viewDidLoad
{
    _noteBiz = [[NoteBiz alloc]init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.sourceType];
        self.delegate = self;
        self.allowsEditing = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnOnclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)photoClick:(id)sender {

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
            Note *note = [[Note alloc]init];
            note.date = [[NSDate alloc]init];
            note.type = 2;
            note.content = imageFilePath;
            [_noteBiz createNote:note];
        }
        else {
            NSLog(@"image wiret to file failed, file is %@", imageFilePath);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:nil userInfo:nil];
}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [picker dismissModalViewControllerAnimated:YES];
//}

@end
