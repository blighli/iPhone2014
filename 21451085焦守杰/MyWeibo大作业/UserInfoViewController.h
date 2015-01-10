//
//  UserInfoViewController.h
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/4.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weibo.h"
#import "OAuthViewController.h"
@interface UserInfoViewController : UIViewController<UIAlertViewDelegate>{
    @private
    Weibo *_weibo;
    NSDictionary *_userInfo;
}

@end
