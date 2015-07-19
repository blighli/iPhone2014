//
//  InnerShadowView.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/8.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "InnerShadowView.h"

@implementation InnerShadowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawInnerShadowInContext:(CGContextRef)context
                        withPath:(CGPathRef)path
                     shadowColor:(CGColorRef)shadowColor
                          offset:(CGSize)offset
                      blurRadius:(CGFloat)blurRadius {
    CGContextSaveGState(context);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    CGColorRef opaqueShadowColor = CGColorCreateCopyWithAlpha(shadowColor, 1.0);
    
    CGContextSetAlpha(context, CGColorGetAlpha(shadowColor));
    CGContextBeginTransparencyLayer(context, NULL);
    CGContextSetShadowWithColor(context, offset, blurRadius, opaqueShadowColor);
    CGContextSetBlendMode(context, kCGBlendModeSourceOut);
    CGContextSetFillColorWithColor(context, opaqueShadowColor);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextEndTransparencyLayer(context);
    
    CGContextRestoreGState(context);
    
    CGColorRelease(opaqueShadowColor);
}

@end
