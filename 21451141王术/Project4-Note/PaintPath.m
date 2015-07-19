//
//  PaintPath.m
//  Project4-Note
//
//  Created by  ws on 11/20/14.
//  Copyright (c) 2014 ws. All rights reserved.
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
