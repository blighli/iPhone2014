//
//  QCBSongModel.h
//  NetMusic
//
//  Created by xsdlr on 14/12/5.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "QCBBaseModel.h"

@interface QCBSongModel : QCBBaseModel
/**
 *  专辑跳转地址
 */
@property(strong,nonatomic) NSString *album;
/**
 *  专辑图片地址
 */
@property(strong,nonatomic) NSString *picture;
/**
 *  内部编号
 */
@property(strong,nonatomic) NSString *ssid;
/**
 *  艺术家
 */
@property(strong,nonatomic) NSString *artist;
/**
 *  歌曲的URL
 */
@property(strong,nonatomic) NSString *url;
/**
 *  唱片公司
 */
@property(strong,nonatomic) NSString *company;
/**
 *  歌曲名
 */
@property(strong,nonatomic) NSString *title;
/**
 *  平均分数
 */
@property(assign,nonatomic) NSInteger rating_avg;
/**
 *  长度
 */
@property(assign,nonatomic) NSInteger length;
/**
 *  子类型
 */
@property(strong,nonatomic) NSString *subtype;
/**
 *  出版年份
 */
@property(strong,nonatomic) NSString *public_time;
/**
 *  歌单数量
 */
@property(assign,nonatomic) NSInteger songlists_count;
/**
 *  歌曲id
 */
@property(strong,nonatomic) NSString *sid;
/**
 *  专辑id
 */
@property(strong,nonatomic) NSString *aid;
/**
 *  哈希值
 */
@property(strong,nonatomic) NSString *sha256;
/**
 *  码率
 */
@property(strong,nonatomic) NSString *kbps;
/**
 *  专辑名
 */
@property(strong,nonatomic) NSString *albumtitle;
/**
 *  是否已喜欢(0为false,1为true)
 */
@property(strong,nonatomic) NSString *like;
@end
