//
//  XLStatusTopView.m
//  XinLang
//
//  Created by 周舟 on 14-10-3.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLStatusTopView.h"
#import "XLBaseStatusFrame.h"
#import "XLStatus.h"
#import "XLUser.h"
#import "UIImageView+WebCache.h"
#import "XLPhotosView.h"
#import "XLPhoto.h"
#import "XLReweetStatusView.h"

@interface XLStatusTopView()
/**
 *  头像
 */
@property(nonatomic, weak) UIImageView *iconView;
/**
 *  会员标识
 */
@property(nonatomic, weak) UIImageView *vipView;
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  内容
 */
@property (nonatomic, weak) UILabel *contentLabel;
/**
 *   微博配图
 */
@property (nonatomic, weak) XLPhotosView *photoViews;
/**
 *  转发微博父控件
 */

@property (nonatomic, weak) XLReweetStatusView *retStatusView;

@end


@implementation XLStatusTopView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = XLColor(250, 250, 250);
        self.userInteractionEnabled = YES;
        //1.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        //2.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        
        [nameLabel setFont:XLStatusNameFont];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        //3.会员
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.hidden = YES;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        //4.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = XLStatusTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        //5.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = XLStatusSourceFont;
        sourceLabel.textColor = XLColor(81, 81, 81);
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        //6.内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = XLStatusContentFont;
        contentLabel.numberOfLines = 0;
        
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        //7.微博配图
        XLPhotosView *photosView = [[XLPhotosView alloc] init];
        [self addSubview:photosView];
        self.photoViews = photosView;
        //8.转发微博
        XLReweetStatusView *retStatusView = [[XLReweetStatusView alloc]init];
        [self addSubview:retStatusView];
        self.retStatusView = retStatusView;
        
        
    }
    
    return self;
}

-(void)setStatusFrame:(XLBaseStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    XLStatus *status = statusFrame.status;
    XLUser *user = status.user;
    //1.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = statusFrame.iconViewF;
    
    //2.昵称
    [self.nameLabel setText:user.name];
    
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    //3.会员图标
    if (statusFrame.status.user.mbtype > 2) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.vipView.frame = statusFrame.vipViewF;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    //4.时间
    [self.timeLabel setText: status.createdTime];
        
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    //5.来源
    //NSLog(@"source:%@",status.source);
    //<a href="http://app.weibo.com/t/feed/63af84" rel="nofollow">vivo智能手机</a>
    //NSString *str = [self stringForSource:status.source];
    //FIXME:
    [self.sourceLabel setText:status.source];
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    //6.正文
    [self.contentLabel setText: status.text];
    self.contentLabel.frame = statusFrame.contentLabelF;
    //7.配图
    if (status.pic_urls.count) {
        self.photoViews.hidden = NO;
        self.photoViews.frame = self.statusFrame.photosViewF;
        //传递数据模型
        self.photoViews.photos = status.pic_urls;
        //NSLog(@"---self.photoViews.photos:%@",self.photoViews.photos);
    }else{
        self.photoViews.hidden = YES;
    }
    XLStatus *retStatus = status.retweeted_status;
    if (retStatus) {
        self.retStatusView.hidden = NO;
        self.retStatusView.frame = self.statusFrame.retweetViewF;
        self.retStatusView.statusFrame = self.statusFrame;
    }else{
        self.retStatusView.hidden = YES;
    }
    
}

//- (NSString *)stringForSource:(NSString *)string
//{
//    NSRange rangeStart = [string rangeOfString:@">"];
//    NSRange rangeEnd = [string rangeOfString:@"</"];
//    rangeStart.length = rangeEnd.location - rangeStart.location - 1;
//    rangeStart.location = rangeStart.location + 1;
//    NSString *str = [string substringWithRange:rangeStart];
//    return str;
//}
@end

















