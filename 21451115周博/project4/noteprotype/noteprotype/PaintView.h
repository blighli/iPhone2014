//
//  PaintView.h
//  noteprotype
//
//  Created by zhou on 14/11/24.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRColorPickerViewController.h"


@interface PaintView : UIView <HRColorPickerViewControllerDelegate>
@property UIColor *color;
@property UIImage *image;
@end
