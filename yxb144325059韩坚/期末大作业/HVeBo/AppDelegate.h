//
//  AppDelegate.h
//  HVeBo
//
//  Created by HJ on 14/12/3.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailHeader.h"
@class User;
@protocol LogEventDelegate <NSObject>
@optional
- (void)login;
- (void)startAction;
@end


@interface AppDelegate : UIResponder <UIApplicationDelegate, WBHttpRequestDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@property (strong, nonatomic) User *user; //wbCurrentUserID对应的用户资料

@property (nonatomic, weak)id<LogEventDelegate> delegate;

@end

