//
//  AppDelegate.h
//  weiBo
//
//  Created by lixu on 14/12/4.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>  
#import "FirstViewController.h"
#define kAppKey         @"4001696098"
#define kRedirectURI    @"https://api.weibo.com/oauth2/default.html"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) FirstViewController *viewController;

@end

