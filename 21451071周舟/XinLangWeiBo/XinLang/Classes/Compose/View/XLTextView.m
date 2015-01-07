//
//  XLTextView.m
//  XinLang
//
//  Created by 周舟 on 14-10-6.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLTextView.h"

@interface XLTextView()

/**
 *  提示信息
 */
@property (nonatomic, weak) UILabel *placeholderLabel;

@end
@implementation XLTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        //1.添加提示文字
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = self.font;
        label.text = @"分享新鲜事";
        
        label.frame = CGRectMake(0, 0, 100, 40);
        [self insertSubview:label atIndex:0];
        self.placeholderLabel = label;
        
        //2.监听文字改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return  self;
}

- (void)textDidChange
{
    self.placeholderLabel.hidden = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
