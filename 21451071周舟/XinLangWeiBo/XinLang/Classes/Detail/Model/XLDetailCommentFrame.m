//
//  XlDetailCommentFrame.m
//  XinLang
//
//  Created by 周舟 on 14-10-16.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XlDetailCommentFrame.h"
#import "XLStatus.h"
#import "XLUser.h"

@interface XLDetailCommentFrame()


@end
@implementation XLDetailCommentFrame

- (void)setStatus:(XLStatus *)status
{
    _status = status;
    
    //cell 的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    //1.头像
    CGFloat iconX  = XLStatusCellBorder;
    CGFloat iconY  = XLStatusCellBorder;
    CGFloat iconWH = XLStatusCellIconWH;
    _iconViewF     = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //2.昵称
    CGFloat nameX               = CGRectGetMaxX(_iconViewF) + XLStatusCellBorder;
    CGFloat nameY               = XLStatusCellBorder;
    NSDictionary *nameAttribute = @{NSFontAttributeName: XLStatusNameFont};
    
    CGSize nameLabelSize = [status.user.name boundingRectWithSize:CGSizeMake(cellW - 4 * XLStatusCellBorder - iconWH, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:nameAttribute context:nil].size;;
    
    _nameLabelF = (CGRect){CGPointMake(nameX, nameY), nameLabelSize};
    
    //3.会员图标
    if(status.user.mbtype > 2){
        CGFloat vipViewW = 14;
        CGFloat vipViewH = 14;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + XLStatusTableBorder;
        CGFloat vipViewY = XLStatusCellBorder + 2;
        
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //4.时间
    CGFloat timeX = CGRectGetMaxX(_iconViewF) + XLStatusCellBorder;
    CGFloat timeY = CGRectGetMaxY(_nameLabelF) + XLStatusTableBorder;
    NSDictionary *timeAttribute = @{NSFontAttributeName: XLStatusTimeFont};
    CGSize timeSize =[self.status.created_at sizeWithAttributes:timeAttribute];
    _timeLabelF = (CGRect){CGPointMake(timeX, timeY), timeSize};
;
    
    //6.内容
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(_iconViewF) + XLStatusTableBorder;
    NSDictionary *contentAttribute = @{NSFontAttributeName: XLStatusContentFont};
    CGSize contentSize =[status.text boundingRectWithSize:CGSizeMake(cellW - 2 * XLStatusCellBorder, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:contentAttribute context:nil].size;
    _contentLabelF = (CGRect){CGPointMake(contentX, contentY), contentSize};
    
    _cellheight = CGRectGetMaxY(_contentLabelF);
}
@end
