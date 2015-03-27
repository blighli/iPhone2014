//
//  BaseStatusCellFrame.m
//  HVeBo
//
//  Created by HJ on 14/12/15.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "IconView.h"
#import "ImageListView.h"

@interface BaseStatusCellFrame()
{
    NSDictionary *_attribute;
    CGSize _withSize;
}
@end

@implementation BaseStatusCellFrame
- (void)setStatus:(Status *)status
{
    _status = status;
    // 利用微博数据计算所有子控件的frame
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
    CGSize screenNameSize = [status.user.screenName boundingRectWithSize:_withSize options:KboundingRectWithSizeOption attributes:_attribute context:nil].size;
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    
    // 会员图标
    if (status.user.mbType != kMBTypeNone) {
        CGFloat mbIconX = CGRectGetMaxX(_screenNameFrame) + kCellBorderWidth;
        CGFloat mbIconY = screenNameY + (screenNameSize.height - kMBIconH) * 0.5;
        _mbIconFrame = CGRectMake(mbIconX, mbIconY, kMBIconW, kMBIconH);
    }
    
    // 3.时间
    CGFloat timeX = screenNameX;
    CGFloat timeY = CGRectGetMaxY(_screenNameFrame) + 2;
    _attribute =@{NSFontAttributeName: kTimeFont};
    //_withSize =  CGSizeMake(cellWidth , MAXFLOAT);
    CGSize timeSize = [status.createdAt boundingRectWithSize:_withSize options:KboundingRectWithSizeOption attributes:_attribute context:nil].size;
    _timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 4.来源
    CGFloat sourceX = CGRectGetMaxX(_timeFrame) + kCellBorderWidth;
    CGFloat sourceY = timeY;
    _attribute =@{NSFontAttributeName: kSourceFont};
    //_withSize =  CGSizeMake(cellWidth , MAXFLOAT);
    CGSize sourceSize = [status.source boundingRectWithSize:_withSize options:KboundingRectWithSizeOption attributes:_attribute context:nil].size;
    _sourceFrame = (CGRect) {{sourceX, sourceY}, sourceSize};
    
    // 5.内容
    CGFloat textX = iconX;
    CGFloat maxY = MAX(CGRectGetMaxY(_sourceFrame), CGRectGetMaxY(_iconFrame));
    CGFloat textY = maxY + kCellBorderWidth;
    _attribute =@{NSFontAttributeName: kTextFont};
    _withSize =  CGSizeMake(cellWidth - kCellBorderWidth*2, MAXFLOAT);
    CGSize textSize = [status.text boundingRectWithSize:_withSize options:KboundingRectWithSizeOption attributes:_attribute context:nil].size;
    _textFrame = (CGRect){{textX, textY}, textSize};
    
    if (status.picUrls.count) { // 6.有配图
        CGFloat imageX = textX;
        CGFloat imageY = CGRectGetMaxY(_textFrame) + kCellBorderWidth;
        CGSize imageSize = [ImageListView imageListSizeWithCount:status.picUrls.count];
        _imageFrame = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
    }else if (status.retweetedStatus) { // 7.有转发的微博
        // 被转发微博整体
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(_textFrame) + 7;
        CGFloat retweetWidth = cellWidth;
        CGFloat retweetHeight = kCellBorderWidth;
        
        //        // 8.被转发微博的昵称
        //        CGFloat retweetedScreenNameX = kCellBorderWidth;
        //        CGFloat retweetedScreenNameY = 7;
        //        NSString *name = [NSString stringWithFormat:@"@%@:", status.retweetedStatus.user.screenName];
        //        //CGSize retweetedScreenNameSize = [name sizeWithFont:kRetweetedScreenNameFont];
        //        _attribute =@{NSFontAttributeName: kRetweetedScreenNameFont};
        //        _withSize =  CGSizeMake(cellWidth , MAXFLOAT);
        //        CGSize retweetedScreenNameSize = [name boundingRectWithSize:_withSize options:KboundingRectWithSizeOption attributes:_attribute context:nil].size;
        //        _retweetedScreenNameFrame = (CGRect){{retweetedScreenNameX, retweetedScreenNameY}, retweetedScreenNameSize};
        
        // 9.被转发微博的内容
        CGFloat retweetedTextX = kCellBorderWidth;
        CGFloat retweetedTextY = 7;
        NSString *retText = [NSString stringWithFormat:@"@%@:%@", status.retweetedStatus.user.screenName,status.retweetedStatus.text];
        status.retweetedStatus.text = retText;
        _attribute =@{NSFontAttributeName: kRetweetedTextFont};
        //_withSize =  CGSizeMake(cellWidth - kCellBorderWidth*2 , MAXFLOAT);
        CGSize retweetedTextSize = [retText boundingRectWithSize:_withSize
                                                         options:KboundingRectWithSizeOption attributes:_attribute context:nil].size;
        _retweetedTextFrame = (CGRect){{retweetedTextX, retweetedTextY}, retweetedTextSize};
        
        // 10.被转发微博的配图
        if (status.retweetedStatus.picUrls.count) {
            CGFloat retweetedImageX = retweetedTextX;
            CGFloat retweetedImageY = CGRectGetMaxY(_retweetedTextFrame) + kCellBorderWidth;
            CGSize retweetedimageSize = [ImageListView imageListSizeWithCount:status.retweetedStatus.picUrls.count];
            _retweetedImageFrame = CGRectMake(retweetedImageX, retweetedImageY, retweetedimageSize.width, retweetedimageSize.height);
            //整一个被转发view的高度
            retweetHeight += CGRectGetMaxY(_retweetedImageFrame);
        } else {
            retweetHeight += CGRectGetMaxY(_retweetedTextFrame);
        }
        _retweetedFrame = CGRectMake(retweetX, retweetY, retweetWidth, retweetHeight);
    }
    // 11.整个cell的高度
    _cellHeight = kCellBorderWidth+KTableViewCellMargin;
    if (status.picUrls.count) {
        _cellHeight += CGRectGetMaxY(_imageFrame);
    } else if (status.retweetedStatus) {
        _cellHeight += CGRectGetMaxY(_retweetedFrame);
        _cellHeight -= kCellBorderWidth;
    } else {
        _cellHeight += CGRectGetMaxY(_textFrame);
    }
}
@end
