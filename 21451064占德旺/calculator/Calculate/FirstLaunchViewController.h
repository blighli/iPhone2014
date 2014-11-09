//
//  FirstLaunchViewController.h
//  Calculate
//
//  Created by Devon on 14/11/6.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstLaunchViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *gotoMainViewBtn;
- (IBAction)gotoMainView:(id)sender;

@end
