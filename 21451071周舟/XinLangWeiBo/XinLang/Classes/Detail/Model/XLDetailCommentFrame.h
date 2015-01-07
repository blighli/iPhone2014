//
//  XlDetailCommentFrame.h
//  XinLang
//
//  Created by 周舟 on 14-10-16.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XLStatus;
@interface XLDetailCommentFrame : NSObject

@property(nonatomic, strong) XLStatus *status;

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
 *  文字内容
 */
@property (nonatomic, readonly,assign) CGRect contentLabelF;

/**
 *  整个cell 的高度
 */
@property (nonatomic, readonly,assign) CGFloat cellheight;
@end
