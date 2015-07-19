//
//  DrawView.m
//  MyNotes
//
//  Created by tanglie on 14/11/23.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()

@property (strong, nonatomic) NSMutableArray *paths;
@end

@implementation DrawView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//lazy load
- (NSMutableArray *)paths{
    if (nil == _paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:touch.view];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path setLineWidth:5];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    
    [path moveToPoint:startPoint];
    [self.paths addObject:path];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:touch.view];
    UIBezierPath *currentPath = [self.paths lastObject];
    [currentPath addLineToPoint:movePoint];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    for (UIBezierPath *path in self.paths) {
        [path stroke];
    }
}
- (void)clearView{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

- (void)backView{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
@end
