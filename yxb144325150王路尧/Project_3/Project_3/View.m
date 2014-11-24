//
//  View.m
//  Project3
//
//  Created by  王路尧 on 14/11/24.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import "View.h"

@interface View ()

@property(nonatomic,strong)NSMutableArray *paths;
@end

@implementation View

-(NSMutableArray *)paths
{
    if (_paths==nil) {
        _paths=[NSMutableArray array];
    }
      return _paths;
    }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch  *touch=[touches anyObject];
    CGPoint starPoint=[touch locationInView:touch.view];
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path setLineWidth:5];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path moveToPoint:starPoint];
    [self.paths addObject:path];
    }

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
     CGPoint movePoint=[touch locationInView:touch.view];
    UIBezierPath *currentPath=[self.paths lastObject];
    [currentPath addLineToPoint:movePoint];
     [self setNeedsDisplay];
    }

- (void)drawRect:(CGRect)rect
{

    for (UIBezierPath *path in self.paths) {
        [path stroke];
        }
    }

-(void)clearView
{

  [self.paths removeAllObjects];
[self setNeedsDisplay];
    }

-(void)backView
{

   [self.paths removeLastObject];
   [self setNeedsDisplay];
}
@end
