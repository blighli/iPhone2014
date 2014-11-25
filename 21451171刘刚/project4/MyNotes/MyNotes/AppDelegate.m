//
//  AppDelegate.m
//  MyNotes
//
//  Created by liug on 14-11-15.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "PhotoViewController.h"
#import "DrawViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    tabBarController=[[UITabBarController alloc]init];//biao qian lan kong zhi qi
    
    navController=[[UINavigationController alloc]init];//初始化导航控制器
    photonavController=[[UINavigationController alloc]init];
    drawnavController=[[UINavigationController alloc]init];
    
    DrawViewController *draw=[[DrawViewController alloc]init];
    draw.title=@"MyDraws";
    PhotoViewController *photo=[[PhotoViewController alloc]init];
    photo.title=@"MyPhotos";
    MainViewController *mainViewController=[[MainViewController alloc]init];
    mainViewController.title=@"MyNotes";
    
    tabBarController.viewControllers=[NSArray arrayWithObjects:navController,photonavController,drawnavController,nil];
    
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]initWithTitle:@"All Notes" style:UIBarButtonItemStyleBordered target:nil action:nil];
    mainViewController.navigationItem.backBarButtonItem=backButton;
    
    UIBarButtonItem *backButton1=[[UIBarButtonItem alloc]initWithTitle:@"All Photos" style:UIBarButtonItemStyleBordered target:nil action:nil];
    photo.navigationItem.backBarButtonItem=backButton1;
    
    UIBarButtonItem *backButton2=[[UIBarButtonItem alloc]initWithTitle:@"All Draws" style:UIBarButtonItemStyleBordered target:nil action:nil];
    draw.navigationItem.backBarButtonItem=backButton2;
    //    PhotoViewController *photo=[[PhotoViewController alloc]init];
    //    photo.title=@"Photos";
    
    //把第一个视图控制器推到堆栈中
    [navController pushViewController:mainViewController animated:NO];
    [photonavController pushViewController:photo animated:NO];
    [drawnavController pushViewController:draw animated:NO];
    //[self.window addSubview:navController.view];
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
