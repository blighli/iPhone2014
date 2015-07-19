//
//  XLTitleButton.m
//  XinLang
//
//  Created by 周舟 on 14-10-9.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLTitleButton.h"

#define XLTitleButtonImageW 20

@implementation XLTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font             = [UIFont systemFontOfSize:19];
        self.imageView.contentMode       = UIViewContentModeCenter;
        self.titleLabel.textAlignment    = NSTextAlignmentRight;
        //背景
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    NSMutableDictionary *_dictionary = [NSMutableDictionary dictionary];
    
    _dictionary[NSFontAttributeName] = [UIFont systemFontOfSize:19];
    CGFloat titleW = [title sizeWithAttributes:_dictionary].width;
    
    CGRect frame = self.frame;
    frame.size.width = titleW + XLTitleButtonImageW + 5;
    self.frame = frame;
    [super setTitle:title forState:state];
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - XLTitleButtonImageW;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = XLTitleButtonImageW;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}
@end
