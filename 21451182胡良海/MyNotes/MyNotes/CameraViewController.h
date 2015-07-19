//
//  CameraViewController.h
//  MyNotes
//
//  Created by hu on 14/11/14.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *cameraimageview;



@end
