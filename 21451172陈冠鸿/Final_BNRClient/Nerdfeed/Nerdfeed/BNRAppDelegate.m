//
//  BNRAppDelegate.m
//  Nerdfeed
//
//  Created by Chen.D.Guanhong on 1/9/15.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRCoursesViewController.h"
#import "BNRWebViewController.h"

@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    BNRCoursesViewController *cvc = [[BNRCoursesViewController alloc] initWithStyle:UITableViewStylePlain];

    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:cvc];

    BNRWebViewController *wvc = [[BNRWebViewController alloc] init];
    cvc.webViewController = wvc;


    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {

        UINavigationController *detailNav =
            [[UINavigationController alloc] initWithRootViewController:wvc];
        UISplitViewController *svc = [[UISplitViewController alloc] init];
        svc.delegate = wvc;

        svc.viewControllers = @[masterNav, detailNav];
        self.window.rootViewController = svc;
    } else {
        self.window.rootViewController = masterNav;
    }

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
