//
//  DetailHeader.m
//  HVeBo
//
//  Created by HJ on 14/12/15.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "DetailHeader.h"
#import "Status.h"

@interface DetailHeader()
{
    UIButton *_selectButton;
}

@end

@implementation DetailHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


+ (id)header
{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailHeader" owner:nil options:nil][0];
}
- (void)awakeFromNib
{
    [self btnClick:_comment];
}
#pragma - 按钮点击事件
- (IBAction)btnClick:(UIButton *)sender
{
    _selectButton.enabled = YES;
    sender.enabled = NO;
    _selectButton = sender;
    //三角指示器
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = _hint.center;
        center.x = sender.center.x;
        _hint.center = center;
    }];
    DetailHeaderBtnType type = (sender==_repost)?kDetailHeaderBtnTypeRepost:kDetailHeaderBtnTypeComment;
    _currentBtnType = type;
    // 通知代理
    if ([_delegate respondsToSelector:@selector(detailHeader:btnClick:)]) {
        [_delegate detailHeader:self btnClick:type];
    }
}
-(void)setStatus:(Status *)status
{
    _status = status;
    // 1.转发
    [self setBtn:_repost title:@"转发" count:status.repostsCount];
    // 2.评论
    [self setBtn:_comment title:@"评论" count:status.commentCount];
    // 3.赞
    [self setBtn:_attitude title:@"赞" count:status.attitudesCount];
}
#pragma mark 设置按钮文字
- (void)setBtn:(UIButton *)btn title:(NSString *)title count:(int)count
{
    if (count >= 10000) { // 上万
        CGFloat final = count / 10000.0;
        title = [NSString stringWithFormat:@"%@ %.1f万",  title, final];
        // 替换.0为空串
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:title forState:UIControlStateNormal];
    } else  { // 一万以内
        title = [NSString stringWithFormat:@"%@ %d", title, count];
        [btn setTitle:title forState:UIControlStateNormal];
    }
}
@end
