//
//  AppDelegate.h
//  MyNotes
//
//  Created by liug on 14-11-15.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *navController,*photonavController,*drawnavController;
    UITabBarController *tabBarController;
}

@property (strong, nonatomic) UIWindow *window;

@end
