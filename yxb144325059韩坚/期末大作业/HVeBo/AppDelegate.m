//
//  AppDelegate.m
//  HVeBo
//
//  Created by HJ on 14/12/3.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "HomeViewController.h"
#import "MainViewController.h"
#import "MMDrawerController.h"
#import "RightViewController.h"
#import "DiscoverViewController.h"
#import "HttpTool.h"
#import "User.h"
#import "HttpTool.h"

@interface AppDelegate ()<WeiboSDKDelegate>
@property (nonatomic, strong)MMDrawerController *drawerController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.hidden = NO;
    //侧滑控件
    MainViewController *mainCtrl = [[MainViewController alloc]init];
    //LeftViewController *leftCtrl = [[LeftViewController alloc] init];
    RightViewController *rightCtrl = [[RightViewController alloc]init];
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:mainCtrl
                             //leftDrawerViewController:leftCtrl
                             rightDrawerViewController:rightCtrl];
    [self.drawerController setMaximumLeftDrawerWidth:180.0];
    [self.drawerController setMaximumRightDrawerWidth:80.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeCustom];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
 
    //////自定义抽屉手势   开始///////////
    [self.drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
        BOOL shouldRecognizeTouch = NO;
        if(drawerController.openSide == MMDrawerSideNone && [gesture isKindOfClass:[UIPanGestureRecognizer class]])
        {
            UINavigationController *nav = (UINavigationController *)mainCtrl.selectController;
            if(nav.childViewControllers.count == 1)
            {//判断哪个控制器可以滑到抽屉
                shouldRecognizeTouch = YES;//返回yes表示可以滑动到左右侧抽屉
            }else{
                shouldRecognizeTouch = NO;
            }
        }
        return shouldRecognizeTouch;
    }];
    //////自定义抽屉手势   结束///////////

    self.window.rootViewController = self.drawerController;
    //初始化微博
    [self _initSinaWeibo];
    
    return YES;
}
- (void)_initSinaWeibo
{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    //从本地持久化数据中获取
    self.wbtoken = [[NSUserDefaults standardUserDefaults] stringForKey:@"wbtoken"];
    self.wbCurrentUserID = [[NSUserDefaults standardUserDefaults] stringForKey:@"userID"];
    if (self.wbCurrentUserID == nil) {
        self.wbCurrentUserID = @"wb1.0";
    }
    if (self.wbtoken == nil || [self.wbtoken isEqualToString:@"wb1.0"]) {
        self.wbtoken = @"wb1.0";
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kRedirectURI;
        request.scope = @"all";
        [WeiboSDK sendRequest:request];
    }else{
        [self userShow];
    }
}
- (void)userShow
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    if (self.wbCurrentUserID) {
        [params setObject:self.wbCurrentUserID forKey:@"uid"];
        [HttpTool wbHttpRequest:@"users/show.json" httpMethod:@"GET" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
            if(!error){
                _user = [[User alloc] initWithDict:result];
                self.user = _user;
                //告诉leftView已经登录成功
                if ([self.delegate respondsToSelector:@selector(startAction)]) {
                    [self.delegate startAction];
                }
            }
        }];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] setObject:self.wbtoken forKey:@"wbtoken"];
    [[NSUserDefaults standardUserDefaults] setObject:self.wbCurrentUserID forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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

#pragma mark - WeiboSDK delegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {//登录成功
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        //持久化到本地
        [[NSUserDefaults standardUserDefaults] setObject:self.wbtoken forKey:@"wbtoken"];
        [[NSUserDefaults standardUserDefaults] setObject:self.wbCurrentUserID forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self userShow];
        [_delegate login];
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        NSString *title = NSLocalizedString(@"支付结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self ];
}
#pragma mark -
#pragma WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"收到网络回调", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    if ([result rangeOfString:@"true"].length) {
        _wbCurrentUserID = @"wb1.0";
        _wbtoken = @"wb1.0";
        [[NSUserDefaults standardUserDefaults] setObject:self.wbtoken forKey:@"wbtoken"];
        [[NSUserDefaults standardUserDefaults] setObject:self.wbCurrentUserID forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    [alert show];
}
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"请求异常", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}
@end
