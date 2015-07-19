//
//  YYView.m
//  HFYHomeWork
//
//  Created by  Mac on 14/12/6.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "YYView.h"

@interface YYView ()

@property(nonatomic,strong)NSMutableArray *paths;
//@property(nonatomic,strong)UIImage *drawImage;
@end

@implementation YYView



#pragma mark-懒加载
-(NSMutableArray *)paths
{
    if (_paths==nil) {
        _paths=[NSMutableArray array];
    }
    return _paths;
}

- (void)drawRect:(CGRect)rect
{
    
    UIGraphicsBeginImageContext(self.frame.size);
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 1.0, 0.0, 1.0);    for (UIBezierPath *path in self.paths) {
        //[path stroke];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
    }
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
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
