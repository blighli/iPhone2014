//
//  TakePhotoViewController.m
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/18.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "TakePhotoViewController.h"
#import "NoteDAO.h"
#import "NoteEntity.h"

@interface TakePhotoViewController ()

@end

@implementation TakePhotoViewController
{
    NoteDAO* _noteDAO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _noteDAO = [NoteDAO new];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.sourceType];
        self.delegate = self;
        self.allowsEditing = YES;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
