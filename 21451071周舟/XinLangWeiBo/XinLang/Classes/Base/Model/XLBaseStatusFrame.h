//
//  XLBaseStatusFrame.h
//  XinLang
//
//  Created by 周舟 on 14-10-14.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XLStatus;

@interface XLBaseStatusFrame : NSObject

@property (nonatomic, strong) XLStatus *status;
/**
 *  顶部的view
 */
@property (nonatomic, readonly, assign) CGRect topViewF;
/**
 *  头像
 */
@property (nonatomic, readonly, assign) CGRect iconViewF;
/**
 *  昵称
 */
@property (nonatomic, readonly, assign) CGRect nameLabelF;
/**
 *  会员图标
 */
@property (nonatomic, readonly, assign) CGRect vipViewF;
/**
 * 配图
 */
@property (nonatomic, readonly, assign) CGRect photosViewF;
/**
 *  时间
 */
@property (nonatomic, readonly,assign) CGRect timeLabelF;
/**
 *  来源
 */
@property (nonatomic, readonly,assign) CGRect sourceLabelF;
/**
 *  文字内容
 */
@property (nonatomic, readonly,assign) CGRect contentLabelF;
/**
 *  被转发微博的VIew
 */
@property (nonatomic, readonly,assign) CGRect retweetViewF;
/**
 *  被转发微博的作者昵称
 */
@property (nonatomic, readonly,assign) CGRect retweetNameLebelF;
/**
 *  被转发微博的内容
 */
@property (nonatomic, readonly,assign) CGRect retweetContentLabelF;
/**
 *  被转发微博的配图
 */
@property (nonatomic, readonly,assign) CGRect retweetPhotosViewF;
/**
 *  底部工具栏
 */
@property (nonatomic, readonly,assign) CGRect statusToolbarF;
/**
 *  整个cell 的高度
 */
@property (nonatomic, readonly,assign) CGFloat cellheight;
@end
