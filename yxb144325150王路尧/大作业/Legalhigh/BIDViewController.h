//
//  ViewController.h
//  Legalhigh
//
//  Created by 王路尧 on 14/12/10.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDViewController : UIViewController
<UIImagePickerControllerDelegate,UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
@property (strong,nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIButton *library;

- (IBAction)shootPictureOrVideo:(id)sender;
- (IBAction)selectExistingPictureOrVideo:(id)sender;

@end

