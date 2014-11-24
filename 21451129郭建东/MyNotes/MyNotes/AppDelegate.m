//
//  AppDelegate.m
//  MyNotes
//
//  Created by cstlab on 14/11/10.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "AppDelegate.h"
#import "NoteTableViewController.h"
#import "NoteDetailViewController.h"
#import "DrawViewController.h"
#import "Camera1ViewController.h"
#import "guoViewController.h"
@interface AppDelegate ()
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    NoteTableViewController *note = [[NoteTableViewController alloc]initWithStyle:UITableViewStylePlain];
  
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:note];
    navController.title = @"Notes";
    [navController.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"user_disabled@2x.png"] withFinishedUnselectedImage:[UIImage imageNamed: @"user_enabled@2x.png"]];
    
    Camera1ViewController *vc2 = [[Camera1ViewController alloc]init];
    vc2.title = @"Camera";
    [vc2.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"camera_disabled@2x.png"] withFinishedUnselectedImage:[UIImage imageNamed: @"camera_enabled@2x.png"]];
    DrawViewController *vc3 = [[DrawViewController alloc]init];
    vc3.title = @"画图";
    
    [vc3.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_frame_disabled@2x.png"] withFinishedUnselectedImage:[UIImage imageNamed: @"tab_frame_enabled@2x.png"]];
    
    guoViewController *viewcontrollers = [[guoViewController alloc] init];
    UINavigationController * controllersss = [[UINavigationController alloc] initWithRootViewController:viewcontrollers];
    controllersss.title =@"网络";
    
    [controllersss.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"globe_disabled@2x.png"] withFinishedUnselectedImage:[UIImage imageNamed: @"globe_enabled@2x.png"]];

    controllersss.tabBarItem.badgeValue = @"10";
    
    NSArray *controllers = [NSArray arrayWithObjects:navController,vc2,vc3,controllersss, nil];
    
    
    
    UITabBarController *tabController = [[UITabBarController alloc]init];
    
    tabController.delegate = self;
    
    tabController.viewControllers = controllers;
    
    self.window.rootViewController = tabController;
        self.window.backgroundColor  = [UIColor whiteColor];
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
}

#pragma  UITabBarController

//是否允许选择不同的item 触发不同的后续操作 yes 允许  no  不允许

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return  YES;
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"Selected");
}
// when tag the more bar
-(void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
    
}

-(void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}

@end
