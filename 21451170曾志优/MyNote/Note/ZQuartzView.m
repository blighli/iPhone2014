//
//  ZQuartzView.m
//  Note
//
//  Created by Mac on 14-11-23.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZQuartzView.h"

@implementation ZQuartzView


- (id)initWithCoder:(NSCoder*)coder {
    NSLog(@"initWithCoder");
    if (self = [super initWithCoder:coder]) {
        _paths = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    //设置路径的相关属性
    [path setLineWidth:5];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    
    //4.设置当前路径的起点
    [path moveToPoint:point];
    
    //5.将路径添加到数组中去
    [_paths addObject:path];
   
  }



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
   
    
    UIBezierPath *path=[_paths lastObject];
    
     CGPoint point = [touch locationInView:self];
    //4.设置当前路径的起点
    [path addLineToPoint:point];
  
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    for (UIBezierPath *path in _paths) {
        [path stroke];
    }
}
@end
