//
//  XLNavationViewController.m
//  XinLang
//
//  Created by 周舟 on 14-10-2.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLNavationViewController.h"

@interface XLNavationViewController ()

@end

@implementation XLNavationViewController

+(void)initialize
{
    [self setupNavTheme];
    
    [self setupButtonItemTheme];
    
}
/**
 *  设置导航栏主题
 */
+ (void)setupNavTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    navBar.titleTextAttributes = textAttrs;
}
/**
 *  设置导航栏按钮主题
 */
+ (void)setupButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableAttrs[NSBackgroundColorAttributeName] = [UIColor lightGrayColor];
    
    [item setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}


@end
