//
//  CellActionView.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/8.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "CellActionView.h"

@implementation CellActionView


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPathRef path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    [self drawInnerShadowInContext:context withPath:path shadowColor:UIColor.blackColor.CGColor offset:CGSizeMake(0, 0) blurRadius:5.0f];
}

@end