//
//  Paint.m
//  NOTEbook
//
//  Created by SXD on 14/12/3.
//  Copyright (c) 2014年 SXD. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Paint.h"
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>

@implementation paintview

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _paintcolor=[UIColor blackColor];
        paints=[[NSMutableArray alloc] init];
        lines=[[NSMutableArray alloc] init];
        Endpoint=[[NSMutableArray alloc] init];
        Startpoint=[[NSMutableArray alloc] init];
        isFirst=true;
    }
    return self;
}
//具体实现绘画的方法
-(void)drawRect:(CGRect)rect{
    context=UIGraphicsGetCurrentContext();
    //线的粗细
    CGContextSetLineWidth(context, 5);
    //画以前
    if (lines.count>0) {
        
        for (int i=0;i<lines.count; i++) {
            NSMutableArray *cell=lines[i];
            NSMutableArray *line=cell[0];
            UIColor *cellcolor=cell[1];
            //ys
            CGContextSetStrokeColorWithColor(context,[cellcolor CGColor]);
            for (NSInteger j=0; j<[line count]; j++) {
                CGPoint point=[[line objectAtIndex:j] CGPointValue];
                if (j==0) {
                    CGContextMoveToPoint(context, point.x, point.y);
                }else{
                    CGContextAddLineToPoint(context, point.x, point.y);
                }
            }
        }
    }
    CGContextStrokePath(context);
    
    if (Startpoint.count>0) {
        for (int i =0; i<Startpoint.count; i++) {
            NSMutableArray *cell=[Startpoint objectAtIndex:i];
            CGPoint cellpoint=[[cell objectAtIndex:0] CGPointValue];
            UIColor *cellColor=[cell objectAtIndex:1];
            //            CGContextSetStrokeColorWithColor(contextcur,[cellColor CGColor]);
            //ys
            CGContextSetFillColorWithColor(context, cellColor.CGColor);
            //点的粗细
            CGContextFillEllipseInRect(context, CGRectMake(cellpoint.x-2.5, cellpoint.y-2.5, 5, 5));
            
        }
    }
    if(Endpoint.count>0){
        for (int i =0; i<Endpoint.count; i++) {
            NSMutableArray *cell=[Endpoint objectAtIndex:i];
            CGPoint cellpoint=[[cell objectAtIndex:0] CGPointValue];
            UIColor *cellColor=[cell objectAtIndex:1];
            //            CGContextSetStrokeColorWithColor(contextcur,[cellColor CGColor]);
            //ys
            CGContextSetFillColorWithColor(context, cellColor.CGColor);
            CGContextFillEllipseInRect(context, CGRectMake(cellpoint.x-2.5, cellpoint.y-2.5, 5, 5));
        }
    }
    CGContextSetStrokeColorWithColor(context, _paintcolor.CGColor);
    //画这次
    if (paints.count>0) {
        CGContextFillEllipseInRect(context, CGRectMake([[paints objectAtIndex:0] CGPointValue].x-2.5, [[paints objectAtIndex:0] CGPointValue].y-2.5, 5, 5));
        if (isFirst) {
            NSMutableArray *cell=[[NSMutableArray alloc] init];
            [cell addObject:[paints objectAtIndex:0]];
            [cell addObject:_paintcolor];
            [Startpoint addObject:cell];
            isFirst=false;
        }
        
        
        CGContextFillEllipseInRect(context, CGRectMake(Curpoint.x-2.5, Curpoint.y-2.5, 5, 5));
        for (NSInteger i=0; i<paints.count; i++) {
            CGPoint point=[[paints objectAtIndex:i] CGPointValue];
            if (i==0) {
                CGContextMoveToPoint(context, point.x, point.y);
            }else{
                CGContextAddLineToPoint(context, point.x, point.y);
            }
        }
        
    }
    CGContextStrokePath(context);
}

-(UIImage *) screenShot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  image;
}
-(void)clear:(BOOL) flag{//清空画布上的内容
    _paintcolor=[UIColor blackColor];
    paints=[[NSMutableArray alloc] init];
    lines=[[NSMutableArray alloc] init];
    Endpoint=[[NSMutableArray alloc] init];
    Startpoint=[[NSMutableArray alloc] init];
    isFirst=true;
    [self setNeedsDisplay];
}


//开始触控操作
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}
//触控点移动操作
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint pt = [touch locationInView:self];
    Curpoint=pt;
    [paints addObject:[NSValue valueWithCGPoint:pt]];
    [self setNeedsDisplay];
}
//失去触控操作
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (paints.count>1) {
        NSMutableArray *cell=[[NSMutableArray alloc] init];
        [cell addObject:[paints objectAtIndex:(paints.count-1)]];
        [cell addObject:_paintcolor];
        [Endpoint addObject:cell];
    }
    NSMutableArray *cell=[[NSMutableArray alloc] init];
    [cell addObject:paints];
    [cell addObject:_paintcolor];
    [lines addObject:cell];
    paints=[[NSMutableArray alloc] init];
    isFirst=true;
    
}

@end