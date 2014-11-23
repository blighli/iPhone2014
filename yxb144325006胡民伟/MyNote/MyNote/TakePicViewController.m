//
//  MainViewController.m
//  MyNote
//
//  Created by Cocoa on 14/11/20.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "TakePicViewController.h"
#import "Note.h"
#import "AppDelegate.h"

@interface TakePicViewController ()
@property (weak, nonatomic) AppDelegate *appdelegate;
@property (strong, nonatomic) NSMutableArray *allNotes;
@end

@implementation TakePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.sourceType];
        self.delegate = self;
        self.allowsEditing = YES;
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(NSString*)kUTTypeImage]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *imagePath = [docPath stringByAppendingPathComponent:@"/image"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss-SSSS"];
        NSDate* nowDate = [[NSDate alloc] init];
        NSString *imageFilePath = [imagePath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate:nowDate], @"jpg"];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        if([imageData writeToFile:imageFilePath atomically:YES]) {
            NSLog(@"image write to file success, file is %@", imageFilePath);
            
            Note *newPicNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.appdelegate.managedObjectContext];
            NSManagedObjectID *noteID = [newPicNote objectID];
            NSString *identifier=[noteID.URIRepresentation absoluteString];
            newPicNote.id = identifier;
            newPicNote.date =[NSDate new];
            newPicNote.type = @"照片";
            newPicNote.content = imageFilePath;
            
            NSError *error = nil;
            BOOL isSave =   [self.appdelegate.managedObjectContext save:&error];
            if (!isSave) {
                NSLog(@"error:%@,%@",error,[error userInfo]);
            }
            else{
                NSLog(@"保存成功");
                [self.allNotes addObject:newPicNote];
            }
        }
        else {
            NSLog(@"image wiret to file failed, file is %@", imageFilePath);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
