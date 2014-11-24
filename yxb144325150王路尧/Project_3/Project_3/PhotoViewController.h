//
//  MasterViewController.h
//  Project_3
//
//  Created by 王路尧 on 14/11/24.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton * takePictureButton;

- (IBAction)shootPictureOrVideo:(id)sender;

- (IBAction)selectExistingPictureOrVideo:(id)sender;


@end

