//
//  DrawViewController.h
//  EverNote
//
//  Created by 陈晓强 on 14/12/3.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmoothLineView.h"
@interface DrawViewController : UIViewController
<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *smthView;
@property (strong , nonatomic) NSString *myTitle;

@property (nonatomic) UIImage *image;

@end
