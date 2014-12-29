//
//  BaseStatusCell.h
//  HVeBo
//
//  Created by HJ on 14/12/15.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseCell.h"
@class BaseStatusCellFrame;


@interface BaseStatusCell : BaseCell
{
    UIImageView *_retweeted; // 被转发微博的父控件
}

@property (nonatomic, strong)BaseStatusCellFrame *statusCellFrame;
@end
