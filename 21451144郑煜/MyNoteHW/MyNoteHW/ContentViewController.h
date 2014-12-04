//
//  ContentViewController.h
//  TODOListHW
//
//  Created by StarJade on 14-11-23.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage-Extensions.h"

@interface ContentViewController : UIViewController <UIImagePickerControllerDelegate>

- (void)viewWillAppear:(BOOL)animated;
- (void)imageIntofastView:(UIImage *)image;

@end
