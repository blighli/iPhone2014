//
//  LineView.m
//  iHabit
//
//  Created by xsdlr on 14/12/17.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "LineView.h"

@implementation LineView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = UIColor.clearColor;
    return self;
}

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.bounds.size.height);
    NSLog(@"%f", self.bounds.size.height);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGContextMoveToPoint(context, self.bounds.origin.x + self.bounds.size.height / 2, self.bounds.origin.y + self.bounds.size.height / 2);
    CGContextAddLineToPoint(context, self.bounds.size.width - self.bounds.size.height / 2, self.bounds.origin.y + self.bounds.size.height / 2);
    CGContextStrokePath(context);
}

@end
