//
//  PaintPath.m
//  Notes
//
//  Created by xsdlr on 14/11/18.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
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
