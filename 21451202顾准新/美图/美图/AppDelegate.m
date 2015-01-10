//
//  AppDelegate.m
//  美图
//
//  Created by 顾准新 on 14-12-18.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"

@interface AppDelegate ()

@property (strong,nonatomic) Reachability *connect;

@end


@implementation AppDelegate
@synthesize splashView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    [self.window makeKeyAndVisible];
    //设置后台获取
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    splashView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, Screen_height)];
    [splashView setImage:[UIImage imageNamed:@"fetchBg1.png"]];
//    
    [self.window addSubview:splashView];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(removeCover) userInfo:nil repeats:NO];
   return YES;
}

-(void)removeCover{
    [splashView removeFromSuperview];
}
//后台获取
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
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
    
    
    //进入后台, 显示
    [self.window addSubview:splashView];
    [self.window bringSubviewToFront:splashView];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    //打开应用, 移除隐藏视图
    [self.splashView removeFromSuperview];

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
