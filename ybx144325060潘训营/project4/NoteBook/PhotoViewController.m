//
//  PhotoViewController.m
//  NoteBook
//
//  Created by Mz on 14-11-23.
//  Copyright (c) 2014年 pxy. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import "PhotoViewController.h"
#import "Note.h"
#import "ViewController.h"
@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.sourceType];
        self.delegate = self;
        self.allowsEditing = YES;
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"docpath = %@", docPath);
        NSString *imagePath = [docPath stringByAppendingPathComponent:@"images"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss_SSSS"];
        NSString* nowDate = [dateFormatter stringFromDate:[NSDate date]];
        NSString *imageFilePath = [imagePath stringByAppendingFormat:@"/%@.%@", nowDate, @"jpg"];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        if([imageData writeToFile:imageFilePath atomically:YES]) {
            Note *note = [Note MR_createEntity];
            note.date = [NSDate date];
            note.content = imageFilePath;
            note.type = [NSNumber numberWithInt:NoteTypePhoto];
            [self.mainView.noteData insertObject:note atIndex:0];
            [self.mainView.tableView reloadData];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
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
