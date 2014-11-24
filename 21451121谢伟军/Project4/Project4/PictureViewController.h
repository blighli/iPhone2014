//
//  PictureViewController.h
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
@interface PictureViewController : UIViewController
@property Note *note;
-(instancetype)initWithNote:(Note *)note;
@end
