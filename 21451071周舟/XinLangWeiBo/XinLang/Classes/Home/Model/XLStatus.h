//
//  XLStatus.h
//  XinLang
//
//  Created by 周舟 on 14-10-2.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XLUser;
@interface XLStatus : NSObject
/**
 *  微博作者
 */
@property (nonatomic, strong) XLUser       *user;
/**
 *  微博内容
 */
@property (nonatomic, copy  ) NSString     *text;
/**
 *  微博来源
 */
@property (nonatomic, copy  ) NSString     *source;
/**
 *  微博的时间
 */
@property(nonatomic, copy) NSString *created_at;
@property (nonatomic, copy, readonly) NSString *createdTime;
/**
 *  微博的ID
 */
@property(nonatomic, copy) NSString *idstr;
/**
 *  微博的图片
 */
@property(nonatomic, strong) NSArray *pic_urls;

@property(nonatomic, strong) NSString *thumbnail_pic;
/**
 *  微博的转发次数
 */
@property(nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property(nonatomic, assign) int comments_count;
/**
 *  微博的被赞数
 */
@property(nonatomic, assign) int attitudes_count;
/**
 *  被转发的微博
 */
@property(nonatomic, strong) XLStatus *retweeted_status;


@end
