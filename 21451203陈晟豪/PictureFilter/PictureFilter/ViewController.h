//
//  ViewController.h
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/18.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDelegate.h"

@interface ViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate,UIPhotoDelegate>

@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *lastChosenMediaType;

@end

