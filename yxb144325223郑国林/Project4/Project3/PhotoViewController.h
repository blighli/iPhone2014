//
//  PhotoViewController.h
//  Project4
//
//  Created by CST-112 on 14-11-19.
//  Copyright (c) 2014年 CST-112. All rights reserved.

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton * takePictureButton;

- (IBAction)shootPictureOrVideo:(id)sender;

- (IBAction)selectExistingPictureOrVideo:(id)sender;

@end
