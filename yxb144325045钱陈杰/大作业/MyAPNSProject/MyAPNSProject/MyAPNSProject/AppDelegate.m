//
//  AppDelegate.m
//  MyAPNSProject
//
//  Created by cstlab on 14-11-19.
//  Copyright (c) 2014年 Tan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*UIMutableUserNotificationAction* action = [[UIMutableUserNotificationAction alloc] init];
    action.identifier = @"action";
    action.title = @"Accept";
    action.activationMode = UIUserNotificationActivationModeForeground;
    
    UIMutableUserNotificationAction* action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.identifier = @"action2";
    action2.title = @"Reject";
    action2.activationMode = UIUserNotificationActivationModeBackground;
    action2.authenticationRequired = YES;
    action2.destructive = YES;
    
    UIMutableUserNotificationCategory* categorys = [[UIMutableUserNotificationCategory alloc]init];
    categorys.identifier = @"alert";
    [categorys setActions:@[action, action2] forContext:UIUserNotificationActionContextMinimal];
    
    UIUserNotificationSettings* setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObjects:categorys,nil, nil]];
    [application registerUserNotificationSettings:setting];*/
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        NSLog(@"current>8.0");
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge];
        //registerForRemoteNotificationTypes this method is deprecated as of ios8;
        NSLog(@"current<8.0");
    }
    
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

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    //注册成功，返回deviceToken
    NSLog(@"Success");
    NSLog(@"%@",deviceToken);
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    //注册失败
    NSLog(@"Failed!");
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"2014");
}

@end
