//
//  WriteViewController.h
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIImage+DrawCaptureView.h"
@class DrawPlaneView;
@interface WriteViewController : UIViewController

@property (strong, nonatomic) IBOutlet DrawPlaneView * drawplane;


- (IBAction)cancle:(id)sender;
- (IBAction)reDraw:(id)sender;
- (IBAction)done:(id)sender;


@end
