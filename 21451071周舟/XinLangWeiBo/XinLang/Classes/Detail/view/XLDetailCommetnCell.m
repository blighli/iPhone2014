//
//  XLDetailCommetnCell.m
//  XinLang
//
//  Created by 周舟 on 14-10-16.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLDetailCommetnCell.h"
#import "XLStatus.h"
#import "XLStatusFrame.h"
#import "XLUser.h"

#import "UIImageView+WebCache.h"
@interface XLDetailCommetnCell()

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
 *  内容
 */
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation XLDetailCommetnCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
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

        
        //6.内容
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = XLStatusContentFont;
        contentLabel.numberOfLines = 0;
        
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
    }
    return self;
}


- (void)setStatusFrame:(XLStatusFrame *)statusFrame
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
    [self.timeLabel setText: status.created_at];
    if([status.created_at isEqualToString:@"刚刚"])
    {
        self.timeLabel.textColor = [UIColor orangeColor];
    }
    
    self.timeLabel.frame = statusFrame.timeLabelF;

    //6.正文
    [self.contentLabel setText: status.text];
    self.contentLabel.frame = statusFrame.contentLabelF;
}

@end
