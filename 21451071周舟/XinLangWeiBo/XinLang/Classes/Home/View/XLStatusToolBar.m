//
//  XLStatusToolBar.m
//  XinLang
//
//  Created by 周舟 on 14-10-3.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLStatusToolBar.h"

#import "XLStatus.h"


@interface XLStatusToolBar()
/**
 *  转发量
 */
@property(nonatomic, weak) UIButton *reweetBtn;
/**
 *  评论量
 */
@property (nonatomic, weak) UIButton *commetnBtn;
/**
 *  赞
 */
@property (nonatomic, weak)UIButton *attitudeBtn;

@property (nonatomic, weak) UIImageView *dividera;
@property (nonatomic, weak) UIImageView *dividerb;
@property (nonatomic, weak) UIImageView *bottomView;
@end


@implementation XLStatusToolBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        //
        self.userInteractionEnabled = YES;
        self.backgroundColor = XLColor(247, 247, 247);
        //添加按钮
        //转发按钮
        self.reweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" highImage:@"timeline_card_middlebottom_highlighted"];
        self.reweetBtn.tag = 0;
        //评论按钮
        self.commetnBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" highImage:@"timeline_card_middlebottom_highlighted"];
        self.commetnBtn.tag = 1;
        //赞
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" highImage:@"timeline_card_middlebottom_highlighted"];
        self.attitudeBtn.tag = 2;
        //添加分隔线
        UIImageView *dividera = [[UIImageView alloc] init];
        [dividera setImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:dividera];
        self.dividera = dividera;
        
        UIImageView *dividerb = [[UIImageView alloc] init];
        [dividerb setImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:dividerb];
        self.dividerb = dividerb;
        //
        UIImageView *bottomView = [[UIImageView alloc] init];
        [bottomView setImage:[UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"]];
        [self addSubview:bottomView];
        self.bottomView = bottomView;
        
        
        
    }
    
    return self;
}

- (UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImageWithName:highImage] forState:UIControlStateHighlighted];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize: 13]];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    //添加点击事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    return btn;
    
}

- (void)btnClick:(UIButton *)btn
{
    
}

-(void)setStatus:(XLStatus *)status
{
    _status = status;
    //
    [self setupBtn:self.reweetBtn originalTitle:@"转发" count:status.reposts_count];
    [self setupBtn:self.commetnBtn originalTitle:@"评论" count:status.comments_count];
    [self setupBtn:self.attitudeBtn originalTitle:@"赞" count:status.attitudes_count];
}


- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)title count:(int)count
{
    if (count > 0) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        }else{
            title = [NSString stringWithFormat:@"%.1f万",count / 10000.0f];
        }
    }
   
    [btn setTitle:title forState:UIControlStateNormal];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1.按钮frmae
    CGFloat btnW = (self.frame.size.width - 4) / 3;
    CGFloat btnH = self.frame.size.height;
    self.reweetBtn.frame = CGRectMake(0, 0, btnW, btnH);
    self.dividera.frame = CGRectMake(btnW, 0, 2, btnH);
    self.commetnBtn.frame = CGRectMake(btnW, 0, btnW, btnH);
    self.dividerb.frame = CGRectMake(btnW *2, 0, 2, btnH);
    self.attitudeBtn.frame = CGRectMake(btnW *2, 0, btnW, btnH);
    
    self.bottomView.frame = CGRectMake(0, btnH, self.frame.size.width, 10);
    
}

@end
