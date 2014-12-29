//
//  UserInfo.h
//  ProjectFinal
//
//  Created by xvxvxxx on 12/29/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property BOOL isLogin;
@property NSString *cookies;
@property NSInteger userID;
@property NSString *name;
@property NSInteger banned;
@property NSInteger likerd;
@property NSInteger played;
@property NSString *userIDString;
@end

//json:{
//    r = 0;
//    "user_info" =     {
//        ck = uSCV;
//        id = 4391875;
//        "is_dj" = 0;
//        "is_new_user" = 0;
//        "is_pro" = 0;
//        name = "X.";
//        "play_record" =         {
//            banned = 27;
//            "fav_chls_count" = 2;
//            liked = 919;
//            played = 15390;
//        };
//        "third_party_info" = "<null>";
//        uid = xx;
//        url = "http://www.douban.com/people/xx/";
//    };
//}