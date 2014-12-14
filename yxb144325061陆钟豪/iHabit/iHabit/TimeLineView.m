//
//  LineView.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/3.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "TimeLineView.h"

@implementation TimeLineView

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    const CGFloat beginX = 0.0f, maxEndX = 174.0f;
    CGFloat centerY = rect.origin.y + (rect.size.height / 2);
    const CGFloat lineWidth = 4.0f;
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    
    CGFloat tipPostionX;
    if(self.progressRatio < 1.0)
    {
        CGFloat currentEndX = beginX + (maxEndX - beginX) * self.progressRatio;
        CGContextMoveToPoint(context, beginX + lineWidth / 2, centerY);
        CGContextAddLineToPoint(context, currentEndX - lineWidth / 2, centerY);
        CGContextStrokePath(context);
        tipPostionX = currentEndX + 8.5;
    }
    else if(self.progressRatio == 1.0)
    {
        CGContextMoveToPoint(context, beginX + lineWidth / 2, centerY);
        CGContextAddLineToPoint(context, maxEndX - lineWidth / 2, centerY);
        
        CGContextMoveToPoint(context, maxEndX - lineWidth / 2 - 6, centerY - 6);
        CGContextAddLineToPoint(context, maxEndX - lineWidth / 2, centerY);
        CGContextAddLineToPoint(context, maxEndX - lineWidth / 2 - 6, centerY + 6);
        CGContextStrokePath(context);
        
        tipPostionX = maxEndX + 8.5;
    }
    else
    {
        CGContextMoveToPoint(context, beginX + lineWidth / 2, centerY);
        CGContextAddLineToPoint(context, maxEndX - lineWidth / 2, centerY);
        
        CGContextMoveToPoint(context, maxEndX - lineWidth / 2 - 6, centerY - 6);
        CGContextAddLineToPoint(context, maxEndX - lineWidth / 2, centerY);
        CGContextAddLineToPoint(context, maxEndX - lineWidth / 2 - 6, centerY + 6);
        
        CGContextMoveToPoint(context, maxEndX - lineWidth / 2 + 1, centerY - 6);
        CGContextAddLineToPoint(context, maxEndX - lineWidth / 2 + 7, centerY);
        CGContextAddLineToPoint(context, maxEndX - lineWidth / 2 + 1, centerY + 6);
        CGContextStrokePath(context);
        
        tipPostionX = maxEndX + 7 + 8.5;
    }
    
    UIFont *font = [UIFont fontWithName:@"Raleway-Tracked" size:16.67];
    [self.tip drawAtPoint:CGPointMake(tipPostionX,  centerY - 12) withAttributes:@{NSFontAttributeName:font}];
    
}

@end
