//
//  Camera1ViewController.h
//  MyNotes
//
//  Created by cstlab on 14/11/14.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Camera1ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *TakePhoto;
@property (strong, nonatomic) IBOutlet UIButton *TurnCameraRollBtn;

- (IBAction)GetCameraPhoto:(id)sender;
- (IBAction)SelectExistingPhoto:(id)sender;

@end
