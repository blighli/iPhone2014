//
//  AppDelegate.h
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/2.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>{
//    NSString* wbtoken;
//    NSString* wbCurrentUserID;
}

@property (strong, nonatomic) UIWindow *window;
//@property  (strong,nonatomic) NSString* wbtoken;
//@property  (strong,nonatomic) NSString* wbCurrentUserID;

@end

