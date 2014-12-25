//
//  BaseCell.h
//  HVeBo
//
//  Created by HJ on 14/12/18.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDHTMLLabel.h"
@class IconView;


@interface BaseCell : UITableViewCell<MDHTMLLabelDelegate>
{
    UIImageView *_bg;
    UIImageView *_selectedBg;
    
    IconView *_icon; // 头像
    UILabel *_screenName; // 昵称
    UIImageView *_mbIcon; // 会员图标
    UILabel *_time; // 时间
    MDHTMLLabel *_text; // 内容
}
- (NSString *)parseLink:(NSString *)text;
@end
