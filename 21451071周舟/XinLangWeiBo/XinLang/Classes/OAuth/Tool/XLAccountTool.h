//
//  XLAccountTool.h
//  XinLang
//
//  Created by 周舟 on 14-9-29.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XLAccount;

@interface XLAccountTool : NSObject

/**
 @brief	存储账号信息
 
 @param account [IN|OUT]
 */
+ (void)saveAccount:(XLAccount *)account;

/**
 @brief	返回存储的账号信息
 
 @return 账号
 */
+ (XLAccount *)account;
@end
