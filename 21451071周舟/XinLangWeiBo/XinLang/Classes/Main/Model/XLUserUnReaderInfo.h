//
//  XLUserUnReaderInfo.h
//  XinLang
//
//  Created by 周舟 on 14-10-12.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLUserUnReaderInfo : NSObject
//新微博未读数
@property(nonatomic ,assign) int status;
//新粉丝数
@property(nonatomic ,assign) int follower;
//	int	新评论数
@property(nonatomic ,assign) int cmt;
//int	新私信数
@property(nonatomic ,assign) int dm	;
//int	新提及我的微博数
@property(nonatomic ,assign) int mention_status;
//int	新提及我的评论数
@property(nonatomic ,assign) int mention_cmt;
//	int	微群消息未读数
@property(nonatomic ,assign) int group;
//int	私有微群消息未读数
@property(nonatomic ,assign) int private_group;
//int	新通知未读数
@property(nonatomic ,assign) int notice;
//int	新邀请未读数
@property(nonatomic ,assign) int invite	;
//int	新勋章数
@property(nonatomic ,assign) int badge;
//int	相册消息未读数
@property(nonatomic ,assign) int photo;

@property(nonatomic ,assign) int messageCount;
@end
