//
//  RSSReaderAppDelegate.h
//  RSSReader

//  Created by alwaysking on 15/1/4.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface RSSReaderAppDelegate : NSObject <UIApplicationDelegate> {
    UITabBarController * _tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow * window;
@property (nonatomic, retain) UITabBarController * tabBarController;

@end
