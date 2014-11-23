//
//  CameraViewController.m
//  MyNotes
//
//  Created by chencheng on 14/11/21.
//  Copyright (c) 2014年 jikexueyuan. All rights reserved.
//

#import "CameraViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "DBUtilis.h"
 

@interface CameraViewController ()

@property (strong, nonatomic) UIImage *image;


@end
@implementation CameraViewController

- (void)viewDidLoad{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.takePictureButton.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateDisplay];
}

- (void)updateDisplay{
    self.imageView.image = self.image;
    self.imageView.hidden = NO;
}

- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error accessing media" message:@"Device doesn't support this media source" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size,  YES, 0);
    [original drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return final;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if ([info[UIImagePickerControllerMediaType] isEqual:(NSString*)kUTTypeImage]) {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        UIImage *shrunkImage = [self shrinkImage:chosenImage toSize:self.imageView.bounds.size];
        self.image = shrunkImage;
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)shootPicture:(id)sender{
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)selectExistingPicture:(id)sender{
    [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)savePicture:(id)sender{
    UIImage *image = self.imageView.image;
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *title = self.descriptionField.text;
    DBUtilis *dbUtility = [[DBUtilis alloc] init];
    [dbUtility insertText:nil OrImage:imageData WithTitle:title ofType:@"image"];
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"添加图片" message:@"恭喜您，添加图片成功"delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];

}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)tapBackground:(id)sender{
    [sender resignFirstResponder];
}
@end
