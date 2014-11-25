//
//  PaintPath.m
//  MySimpleNote
//
//  Created by 周舟 on 24/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "PaintPath.h"

@implementation PaintPath
- (instancetype)initWithColor:(UIColor *)color width:(CGFloat)width path:(UIBezierPath *)path {
    _color = color;
    _width = width;
    _path = path;
    return self;
}


@end
