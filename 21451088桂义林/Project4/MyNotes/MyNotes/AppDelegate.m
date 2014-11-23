//
//  AppDelegate.m
//  MyNotes
//
//  Created by YilinGui on 14-11-22.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "AppDelegate.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "TextTableViewController.h"
#import "DrawTableViewController.h"
#import "PhotoTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 使用MagicalRecord
    [MagicalRecord setupCoreDataStackWithStoreNamed: @"Model.sqlite"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 创建文本笔记列表的VC
    TextTableViewController *textTableVC = [[TextTableViewController alloc] init];
    textTableVC.tabBarItem.title = @"Text Notes";
    textTableVC.tabBarItem.image = [UIImage imageNamed:@"text"];
    
    // 创建文本笔记的NC
    UINavigationController *textNC = [[UINavigationController alloc] initWithRootViewController: textTableVC];
    
    // 创建手绘笔记列表的VC
    DrawTableViewController *drawTableVC = [[DrawTableViewController alloc] init];
    drawTableVC.tabBarItem.title = @"Draw Notes";
    drawTableVC.tabBarItem.image = [UIImage imageNamed:@"draw"];
    
    // 创建手绘笔记的NC
    UINavigationController *drawNC = [[UINavigationController alloc] initWithRootViewController: drawTableVC];
    
    // 创建照片笔记列表的VC
    PhotoTableViewController *photoTableVC = [[PhotoTableViewController alloc] init];
    photoTableVC.tabBarItem.title = @"Photo Notes";
    photoTableVC.tabBarItem.image = [UIImage imageNamed:@"camera"];
    
    // 创建照片笔记的NC
    UINavigationController *photoNC = [[UINavigationController alloc] initWithRootViewController: photoTableVC];
    
    // 创建TabBarController
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    // 添加3个VC
    tabBarController.viewControllers = [NSArray arrayWithObjects:textNC, drawNC, photoNC, nil];
    
    //tabBarController.tabBar.tintColor = [UIColor purpleColor];
    
    [tabBarController setDelegate:self];
    
    [self.window setRootViewController:tabBarController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
}

@end
