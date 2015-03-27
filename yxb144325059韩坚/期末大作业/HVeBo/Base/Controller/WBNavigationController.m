//
//  WBNavigationController.m
//  HVeBo
//
//  Created by HJ on 14/12/14.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "WBNavigationController.h"
#import "UIImage+MJ.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController
- (void)viewDidLoad
{
    [super viewDidLoad];

    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    // 修改item上面的文字样式
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0 green:0 blue:0 alpha:1]};
    [barItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];

    //滑动返回手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)swipeAction:(UISwipeGestureRecognizer *)gesture
{
    if (self.viewControllers.count > 1) {
        if(gesture.direction == UISwipeGestureRecognizerDirectionRight)
        {
            [self popViewControllerAnimated:YES];
        }
    }
}
@end
