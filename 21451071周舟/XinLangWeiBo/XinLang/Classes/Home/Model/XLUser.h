//
//  XLUser.h
//  XinLang
//
//  Created by 周舟 on 14-10-2.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLUser : NSObject
/**
 *  用户的ID
 */
@property (nonatomic, copy  ) NSString        *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy  ) NSString        *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy  ) NSString        *profile_image_url;

///**
// *  会员等级
// */
@property (nonatomic, assign) int             mbrank;
///**
// *  会员类型
// */
//
@property (nonatomic, assign) int      mbtype;
@property (nonatomic, assign) int      followers_count;
@property (nonatomic, assign) int      friends_count;
@property (nonatomic, assign) int      statuses_count;
@property (nonatomic, copy  ) NSString *s_description;
@property (nonatomic, copy  ) NSString *avatar_large;

@end
