//
//  BsaeTextCellFrame.h
//  HVeBo
//
//  Created by HJ on 14/12/17.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseText;
@interface BaseTextCellFrame : NSObject
@property (nonatomic, strong)BaseText *baseText;

@property (nonatomic, readonly) CGFloat cellHeight; // Cell的高度
@property (nonatomic, readonly) CGRect iconFrame; // 头像的frame
@property (nonatomic, readonly) CGRect screenNameFrame; // 昵称
@property (nonatomic, readonly) CGRect mbIconFrame; // 会员头像
@property (nonatomic, readonly) CGRect timeFrame; // 时间
@property (nonatomic, readonly) CGRect textFrame; // 内容
@end 
