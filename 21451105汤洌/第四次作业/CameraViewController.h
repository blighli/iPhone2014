//
//  CameraViewController.h
//  MyNotes
//
//  Created by tanglie on 14/11/22.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;

@property (weak, nonatomic) IBOutlet   UITextField *descriptionField;

- (IBAction)textFieldDoneEditing:(id)sender;

- (IBAction)tapBackground:(id)sender;

- (IBAction)shootPicture:(id)sender;
- (IBAction)selectExistingPicture:(id)sender;

- (IBAction)savePicture:(id)sender;
@end
