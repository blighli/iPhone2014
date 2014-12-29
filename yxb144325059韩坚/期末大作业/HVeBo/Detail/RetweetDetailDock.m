//
//  RetweetDetailDock.m
//  HVeBo
//
//  Created by HJ on 14/12/15.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "RetweetDetailDock.h"
#import "UIImage+MJ.h"
#import "Status.h"

@interface RetweetDetailDock()
{
    UIButton *_repost;
    UIButton *_comment;
    UIButton *_attitute;
}

@end

@implementation RetweetDetailDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加3个按钮
        _repost = [self addBtn:@"转发" icon:@"timeline_icon_retweet.png"  index:0];
        _comment = [self addBtn:@"评论" icon:@"timeline_icon_comment.png"  index:1];
        _attitute = [self addBtn:@"赞" icon:@"timeline_icon_unlike.png"  index:2];
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    frame.size.width = 200;
    frame.size.height = kDetailDockHeight;
    [super setFrame:frame];
}
- (UIButton *)addBtn:(NSString *)title icon:(NSString *)icon index:(int)index
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 标题
    [btn setTitle:title forState:UIControlStateNormal];
    // 图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    // 普通背景
    //[btn setBackgroundImage:[UIImage resizedImage:@"common_card_background.png"] forState:UIControlStateNormal];
    // 高亮背景
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_feedcard_retweet_background_highlighted.png"] forState:UIControlStateHighlighted];
    // 文字颜色
    [btn setTitleColor:kColor(188, 188, 188) forState:UIControlStateNormal];
    // 字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    // 设frame
    CGFloat w = self.frame.size.width / 3;
    btn.frame = CGRectMake(index * w, 0, w, kStatusDockHeight);
    // 文字左边会空出10的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:btn];

    return btn;
}

-(void)setStatus:(Status *)status
{
    _status = status;
    // 1.转发
    [self setBtn:_repost title:@"0" count:status.repostsCount];
    // 2.评论
    [self setBtn:_comment title:@"0" count:status.commentCount];
    // 3.赞
    [self setBtn:_attitute title:@"0" count:status.attitudesCount];
}
#pragma mark 设置按钮文字
- (void)setBtn:(UIButton *)btn title:(NSString *)title count:(int)count
{
    if (count >= 10000) { // 上万
        CGFloat final = count / 10000.0;
        NSString *title = [NSString stringWithFormat:@"%.1f万", final];
        // 替换.0为空串
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:title forState:UIControlStateNormal];
    } else if (count > 0) { // 一万以内
        NSString *title = [NSString stringWithFormat:@"%d", count];
        [btn setTitle:title forState:UIControlStateNormal];
    } else { // 没有
        [btn setTitle:title forState:UIControlStateNormal];
    }
}
@end
