//
//  PictureViewController.h
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "PictureView.h"
@interface PictureViewController : UIViewController
@property (strong, nonatomic) IBOutlet PictureView *picture;
@property Note *note;
-(instancetype)initWithNote:(Note *)note;
- (IBAction)savePicture:(UIBarButtonItem *)sender;
- (IBAction)clearPicture:(UIBarButtonItem *)sender;

@end
