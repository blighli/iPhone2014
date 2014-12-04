//
//  DrawPlaneView.m
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//


#import "DrawPlaneView.h"
@interface DrawPlaneView()


@property(nonatomic,strong)NSMutableArray * paths;

@end

@implementation DrawPlaneView


-(NSMutableArray *)paths
{
    if (_paths ==nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // 根据路径绘制所有的线段
    for (UIBezierPath *path in self.paths) {
        [path stroke];
    }
}



-(void)cleanView
{
    [self.paths removeAllObjects];
    //用来重新绘制
    [self setNeedsDisplay];
}
-(void)backView
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint  startpoint = [touch locationInView:touch.view];
    //当用户手指按下的时候绘制一条路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:5];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path moveToPoint:startpoint];
    [self.paths addObject:path];
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    CGPoint movepoint = [touch locationInView:touch.view];
    UIBezierPath * currentpath = [self.paths lastObject];
    [currentpath addLineToPoint:movepoint];
    [self setNeedsDisplay];
    
}




@end
