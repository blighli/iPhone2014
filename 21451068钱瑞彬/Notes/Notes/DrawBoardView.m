//
//  DrawBoardView.m
//  Notes
//
//  Created by apple on 14-11-23.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import "DrawBoardView.h"

@implementation DrawBoardView


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch* touch = [touches anyObject];
    CGPoint starPoint = [touch locationInView:touch.view];
    CGPathMoveToPoint(_paths, nil, starPoint.x, starPoint.y);
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:touch.view];
    CGPathAddLineToPoint(_paths, nil, movePoint.x, movePoint.y);
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3);
    CGContextAddPath(context, _paths);
    CGContextStrokePath(context);
}


@end
