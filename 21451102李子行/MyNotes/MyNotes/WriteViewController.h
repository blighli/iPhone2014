//
//  WriteViewController.h
//  MyNotes
//
//  Created by lzx on 24/11/14.
//  Copyright (c) 2014年 lzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+DrawCaptureView.h"
@class DrawPlaneView;
@interface WriteViewController : UIViewController

@property (strong, nonatomic) IBOutlet DrawPlaneView * drawplane;


- (IBAction)drawBack:(UIButton *)sender;

- (IBAction)drawClean:(UIButton *)sender;

@end
