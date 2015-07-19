//
//  OAuthViewController.h
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/2.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weibo.h"
#import "MyFriendViewController.h"
@class User;
@interface OAuthViewController : UIViewController<UIWebViewDelegate>{
    NSString *_code;
    User *user;
    Weibo *weibo;
}

@end
