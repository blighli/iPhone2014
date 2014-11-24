//
//  WriteViewController.h
//  MyNotes
//
//  Created by 张榕明 on 14/11/22.
//  Copyright (c) 2014年 张榕明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+DrawCaptureView.h"
@class DrawPlaneView;
@interface WriteViewController : UIViewController

@property (strong, nonatomic) IBOutlet DrawPlaneView * drawplane;


- (IBAction)drawBack:(UIButton *)sender;

- (IBAction)drawClean:(UIButton *)sender;

@end
