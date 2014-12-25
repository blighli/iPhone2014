//
//  BsaeTextCellFrame.m
//  HVeBo
//
//  Created by HJ on 14/12/17.
//  Copyright (c) 2014年 hj. All rights reserved.
//a

#import "BaseTextCellFrame.h"
#import "IconView.h"
#import "BaseText.h"
#import "User.h"

@interface BaseTextCellFrame()
{
    NSDictionary *_attribute;
    CGSize _withSize;
}
@end
@implementation BaseTextCellFrame
-(void)setBaseText:(BaseText *)baseText
{
    _baseText = baseText;
    // 整个cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    // 1.头像
    CGFloat iconX = kCellBorderWidth;
    CGFloat iconY = kCellBorderWidth;
    CGSize iconSize = [IconView iconSizeWithType:kIconTypeSmall];
    _iconFrame = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    
    // 2.昵称
    CGFloat screenNameX = CGRectGetMaxX(_iconFrame) + kCellBorderWidth;
    CGFloat screenNameY = iconY;
    _attribute =@{NSFontAttributeName: kScreenNameFont};
    _withSize =  CGSizeMake(cellWidth , MAXFLOAT);
    CGSize screenNameSize = [baseText.user.screenName boundingRectWithSize:_withSize options:KboundingRectWithSizeOption attributes:_attribute context:nil].size;
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    // 会员图标
    if (baseText.user.mbType != kMBTypeNone) {
        CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) + kCellBorderWidth;
        CGFloat mbIconY = screenNameY + (screenNameSize.height - kMBIconH) * 0.5;
        _mbIconFrame = CGRectMake(mbIconX, mbIconY, kMBIconW, kMBIconH);
    }
    
    //转发、评论内容
    CGFloat textX = screenNameX;
    CGFloat textY = CGRectGetMaxY(_screenNameFrame) + kCellBorderWidth;
    _attribute =@{NSFontAttributeName: kTextFont};
    _withSize =  CGSizeMake(cellWidth - kCellBorderWidth*2 - textX, MAXFLOAT);
    CGSize textSize = [baseText.text boundingRectWithSize:_withSize options:KboundingRectWithSizeOption attributes:_attribute context:nil].size;
    _textFrame = (CGRect){{textX,textY},textSize};
    
    //时间
    CGFloat timeX = textX;
    CGFloat timeY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
    CGSize tiemSize = CGSizeMake(200, kTimeFont.lineHeight);
    _timeFrame = (CGRect){{timeX,timeY},tiemSize};
    
    //cell高度
    _cellHeight = CGRectGetMaxY(_timeFrame) + kCellBorderWidth;
}

@end
