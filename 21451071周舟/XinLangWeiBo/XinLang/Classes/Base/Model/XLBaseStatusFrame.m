//
//  XLBaseStatusFrame.m
//  XinLang
//
//  Created by 周舟 on 14-10-14.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLBaseStatusFrame.h"
#import "XLStatus.h"
#import "XLUser.h"
#import "XLPhotosView.h"

@implementation XLBaseStatusFrame


- (void)setStatus:(XLStatus *)status
{
    _status = status;
    
    //cell 的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat topViewH = 0;
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
    CGSize timeSize =[self.status.createdTime sizeWithAttributes:timeAttribute];
    _timeLabelF = (CGRect){CGPointMake(timeX, timeY), timeSize};
    
    //5.来源
    CGFloat sourceX = CGRectGetMaxX(_timeLabelF) + XLStatusTableBorder;
    CGFloat sourceY = timeY;
    NSDictionary *sourceAttribute = @{NSFontAttributeName: XLStatusTimeFont};
    CGSize sourceSize =[self.status.source sizeWithAttributes:sourceAttribute];
    _sourceLabelF = (CGRect){CGPointMake(sourceX, sourceY), sourceSize};
    
    //6.内容
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(_iconViewF) + XLStatusTableBorder;
    NSDictionary *contentAttribute = @{NSFontAttributeName: XLStatusContentFont};
    CGSize contentSize =[status.text boundingRectWithSize:CGSizeMake(cellW - 2 * XLStatusCellBorder, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:contentAttribute context:nil].size;
    _contentLabelF = (CGRect){CGPointMake(contentX, contentY), contentSize};
    
    //7.配图
    if (self.status.pic_urls.count) {
        
        // NSLog(@"self.status.pic_urls:%@", self.status.pic_urls);
        CGFloat picX = XLStatusCellBorder;
        CGFloat picY = CGRectGetMaxY(_contentLabelF) + XLStatusTableBorder;
        
        CGSize picSize = [XLPhotosView photoViewSizeWithPhotoCount:(int)self.status.pic_urls.count];
        _photosViewF = (CGRect){CGPointMake(picX, picY), picSize};
        //NSLog(@"_photosViewF:%@",NSStringFromCGRect(_photosViewF));
        
    }else{
        _photosViewF = CGRectZero;
    }
    //8.被转发的微博
    if (status.retweeted_status)
    {
        
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + XLStatusTableBorder;
        CGFloat retweetViewH = 0;
        CGFloat retweetViewW = cellW;
        
        //9、被转发的微博的昵称
        CGFloat retweetedUserNameX = XLStatusCellBorder;
        CGFloat retweetedUserNameY = XLStatusTableBorder;
        NSDictionary *retweetedUserNameA = @{NSFontAttributeName: XLRetweetStatusNameFont};
        NSString *retName = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
        CGSize retweetedUserSize = [retName boundingRectWithSize:CGSizeMake(cellW - 2 * XLStatusCellBorder, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:retweetedUserNameA context:nil].size;
        _retweetNameLebelF = (CGRect){CGPointMake(retweetedUserNameX, retweetedUserNameY), retweetedUserSize};
        
        //10.被转发微博的内容
        CGFloat retweetedContentX = XLStatusCellBorder;
        CGFloat retweetedContentY = CGRectGetMaxY(_retweetNameLebelF) + XLStatusTableBorder;
        NSDictionary *retweetedConA = @{NSFontAttributeName : XLRetweetStatusContentFont};
        CGSize retweetedContentSize = [status.retweeted_status.text boundingRectWithSize:CGSizeMake(cellW - 2 * XLStatusCellBorder, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:retweetedConA context:nil].size;
        _retweetContentLabelF = (CGRect){CGPointMake(retweetedContentX, retweetedContentY), retweetedContentSize};
        
        //11.被转发微博的配图
        if (status.retweeted_status.pic_urls.count) {
            
            // NSLog(@"self.status.pic_urls:%@", self.status.pic_urls);
            CGFloat picX = XLStatusCellBorder;
            CGFloat picY = CGRectGetMaxY(_retweetContentLabelF) + XLStatusTableBorder;
            
            CGSize picSize = [XLPhotosView photoViewSizeWithPhotoCount:(int)self.status.retweeted_status.pic_urls.count];
            _retweetPhotosViewF = (CGRect){CGPointMake(picX, picY), picSize};
            //
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF);
            
        }else{
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        //被转发微博的rect
        retweetViewH += XLStatusTableBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        //有转发微博时的topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
        
    }else{
        if (status.pic_urls.count) {//有配图
            topViewH = CGRectGetMaxY(_photosViewF);
        }else{//无配图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += XLStatusTableBorder;
    _topViewF = CGRectMake(0, 0, cellW, topViewH);
    
    //工具条
    CGFloat statusToolbarX = 0;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = cellW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    
    _cellheight = CGRectGetMaxY(_statusToolbarF) + XLStatusTableBorder;
    //NSLog(@"---_cellheight:%f",_cellheight);
    
}
@end
