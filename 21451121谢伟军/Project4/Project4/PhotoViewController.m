//
//  PhotoViewController.m
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.note == nil) {
        self.note = [[Note alloc]init];
    }
    // Do any additional setup after loading the view.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        self.shootPhotoButton = nil;
    }
    self.image = [UIImage imageWithContentsOfFile:self.note.photo];
//    self.image = [UIImage imageNamed:@"photo"];
    if (self.image == nil) {
        NSLog(@"图片载入失败");
    }
    self.photo.image = self.image;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.photo.image = self.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithNote:(Note *)note{
    self = [super init];
    if (self) {
        self.note = note;
    }
    return self;
}

- (IBAction)shootPhoto:(UIBarButtonItem *)sender {
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
- (IBAction)selectPhoto:(UIBarButtonItem *)sender {
    [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateDisplay
{
    self.photo.image = self.image;
}

- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if ([UIImagePickerController
         isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGFloat originalAspect = original.size.width / original.size.height;
    CGFloat targetAspect = size.width / size.height;
    CGRect targetRect;
    if (originalAspect > targetAspect) {
        // original is wider than target
        targetRect.size.width = size.width;
        targetRect.size.height = size.height * targetAspect / originalAspect;
        targetRect.origin.x = 0;
        targetRect.origin.y = (size.height - targetRect.size.height) * 0.5;
    } else if (originalAspect < targetAspect) {
        // original is narrower than target
        targetRect.size.width = size.width * originalAspect / targetAspect;
        targetRect.size.height = size.height;
        targetRect.origin.x = (size.width - targetRect.size.width) * 0.5;
        targetRect.origin.y = 0;
    } else {
        // original and target have same aspect ratio
        targetRect = CGRectMake(0, 0, size.width, size.height);
    }
    
    [original drawInRect:targetRect];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return final;
}

#pragma mark - Image Picker Controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([info[UIImagePickerControllerMediaType] isEqual:(NSString *)kUTTypeImage]) {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        self.image = [self shrinkImage:chosenImage
                                toSize:self.photo.bounds.size];
        //存储图片文件
        if (self.note.photo == nil) {
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *photoPath = [docPath stringByAppendingPathComponent:@"photo"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager createDirectoryAtPath:photoPath withIntermediateDirectories:YES attributes:nil error:nil];
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            [dateFormatter setDateFormat:@"yy_MM_dd_HH_mm_ss"];
            NSDate* nowDate = [[NSDate alloc] init];
            NSString *photoFilePath = [photoPath stringByAppendingFormat:@"/%@.%@", [dateFormatter stringFromDate:nowDate], @"jpg"];
            self.note.photo = photoFilePath;
        }
        NSData *imageData = UIImageJPEGRepresentation(self.image, 1);
        if([imageData writeToFile:self.note.photo atomically:YES]) {
            NSLog(@"photo write success, file is %@", self.note.photo);
        }
        else {
            NSLog(@"photo wiret failed, file is %@", self.note.photo);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
