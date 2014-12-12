//
//  HttpController.h
//  DoubanFM
//
//  Created by 陈聪荣 on 14/12/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpController : NSObject

//typedef NS_ENUM(NSInteger, DoubanType) {
//    DoubanChannel,
//    DoubanSong
//};
//请求豆瓣歌单
- (NSMutableArray*) requestDoubanSongsWithChannel:(NSInteger) channelId;
//请求豆瓣频道列表
- (NSMutableArray*) requestDoubanChannels;
//请求豆瓣歌曲图片
- (NSData*) requestSongImage:(NSString*) imageUrl;

@end
