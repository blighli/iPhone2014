//
//  ChannelViewController.h
//  NetMusic
//
//  Created by xsdlr on 14/12/4.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "QCBChannelModel.h"

@interface ChannelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
/**
 *  view的宽度
 */
@property(assign,nonatomic) CGFloat width;

/**
 *  是否展现
 */
@property(assign,nonatomic) BOOL isShowed;
/**
 *  开关频道栏
 */
- (void) toggleChannelView;
/**
 *  添加频道信息
 *
 *  @param channels 频道数组
 */
- (void) addChannels:(NSArray*) channels;
/**
 *  添加单个频道信息
 *
 *  @param channel 频道信息
 */
- (void) addChannel:(QCBChannelModel*) channel;
/**
 *  移除所有频道信息
 */
- (void) removeAllChannels;
/**
 *  通知界面大小变化
 */
- (void) fireResize;
@end
