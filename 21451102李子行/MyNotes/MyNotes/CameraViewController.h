//
//  CameraViewController.h
//  MyNotes
//
//  Created by lzx on 24/11/14.
//  Copyright (c) 2014年 lzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *cameraimageview;



@end
