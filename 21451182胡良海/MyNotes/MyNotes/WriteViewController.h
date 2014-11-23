//
//  WriteViewController.h
//  MyNotes
//
//  Created by hu on 14/11/14.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+DrawCaptureView.h"
@class DrawPlaneView;
@interface WriteViewController : UIViewController

@property (strong, nonatomic) IBOutlet DrawPlaneView * drawplane;


- (IBAction)drawBack:(UIButton *)sender;

- (IBAction)drawClean:(UIButton *)sender;

@end
