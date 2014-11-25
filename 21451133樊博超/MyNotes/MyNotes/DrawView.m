//
//  DrawView.m
//  MyNotes
//
//  Created by 樊博超 on 14-11-23.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect");
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIBezierPath *path in _pathArray) {
        CGContextAddPath(context, path.CGPath);
        [[UIColor blackColor] set];
        CGContextSetLineWidth(context, 10.0f);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
    if (_isHavePath) {
        CGContextAddPath(context, _path);
        [[UIColor blackColor] set];
        CGContextSetLineWidth(context, 10.0f);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"begin");
    self.currentColor = [UIColor blackColor];
    UITouch *touch = [touches anyObject];
    _firstTouch = [touch locationInView:self];

    _path = CGPathCreateMutable();
    _isHavePath = YES;
    CGPathMoveToPoint(_path, NULL, _firstTouch.x, _firstTouch.y);
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"end");
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:_path];
    [_pathArray addObject:path];
    CGPathRelease(_path);
    _isHavePath = NO;

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"move");
    UITouch *touch = [touches anyObject];
    _lastTouch = [touch locationInView:self];
    CGPathAddLineToPoint(_path, NULL, _lastTouch.x, _lastTouch.y);
    [self setNeedsDisplay];
}

-(void)clear{
//    self.clearsContextBeforeDrawing = YES;
//    [self setNeedsDisplay];
//    self.clearsContextBeforeDrawing = NO;
    [_pathArray removeAllObjects];
    [self setNeedsDisplay];
   // self.clearsContextBeforeDrawing = NO;
   // CGContextClearRect(UIGraphicsGetCurrentContext(), self.frame);
}


@end
