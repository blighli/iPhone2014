//
//  ViewController.h
//  HFYHomeWork
//
//  Created by  Mac on 14/12/6.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;

- (IBAction)shootPicture:(id)sender;

- (IBAction)slectExistingPicture:(id)sender;

- (IBAction)saveButton:(id)sender;

- (IBAction)backButton:(id)sender;

- (IBAction)clearButton:(id)sender;

@end

