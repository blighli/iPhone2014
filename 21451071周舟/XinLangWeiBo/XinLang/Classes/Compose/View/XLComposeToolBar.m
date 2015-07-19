//
//  XLComposeToolBar.m
//  XinLang
//
//  Created by 周舟 on 14-10-7.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLComposeToolBar.h"

@interface XLComposeToolBar()

@end


@implementation XLComposeToolBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        //添加按钮
        [self addButtonWithImage:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" tag:XLComposeToolbarButtonTypeCamera];
        [self addButtonWithImage:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" tag:XLComposeToolbarButtonTypePicture];
        [self addButtonWithImage:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" tag:XLComposeToolbarButtonTypeTrend];
        [self addButtonWithImage:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" tag:XLComposeToolbarButtonTypeMention];
        [self addButtonWithImage:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" tag:XLComposeToolbarButtonTypeEmotion];
    }
    
    return self;
}

- (void) addButtonWithImage:(NSString *)image highImage:(NSString *)highIamge tag:(int)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIamge] forState:UIControlStateHighlighted];
    
    [self addSubview:button];
    
}

- (void)btnClick:(UIButton *)btn
{
    //NSLog(@"XLComposeToolBar:btnClick:%d",btn.tag);
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickButton:)]) {
        [self.delegate composeToolBar:self didClickButton:btn.tag];
        //NSLog(@"XLComposeToolBar:btnClick:%d",btn.tag);
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    
    for (int i = 0; i < self.subviews.count; i ++) {
        UIButton *button = self.subviews[i];
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
    }
}

@end
