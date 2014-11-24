//
//  ShouxieImage.m
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-23.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShouxieImage.h"

@implementation ShouxieImage
+(void)cleanAllLine
{
    allline = NO;
}
- (void)drawRect:(CGRect)rect
{
    NSLog(@"Thes is drawRect ");
    //获取上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //设置笔冒
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置画线的连接处　拐点圆滑
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //第一次时候个myallline开辟空间
    if (allline==NO)
    {
        myallline=[[NSMutableArray alloc] initWithCapacity:10];
        allline=YES;
    }
    //画之前线
    if ([myallline count]>0)
    {
        for (int i=0; i<[myallline count]; i++)
        {
            NSLog(@"**drawing**");
            NSArray* tempArray=[NSArray arrayWithArray:[myallline objectAtIndex:i]];
            
            if ([tempArray count]>1)
            {
                CGContextBeginPath(context);
                CGPoint myStartPoint=[[tempArray objectAtIndex:0] CGPointValue];
                CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
                
                for (int j=0; j<[tempArray count]-1; j++)
                {
                    CGPoint myEndPoint=[[tempArray objectAtIndex:j+1] CGPointValue];
                    //--------------------------------------------------------
                    CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
                }
                CGContextSetStrokeColorWithColor(context,[[UIColor redColor] CGColor]);
                //-------------------------------------------------------
                CGContextSetLineWidth(context, 1);
                CGContextStrokePath(context);
            }
        }
    }
    //画当前的线
    if ([myallpoint count]>1)
    {
        CGContextBeginPath(context);
        //-------------------------
        //起点
        //------------------------
        CGPoint myStartPoint=[[myallpoint objectAtIndex:0]   CGPointValue];
        CGContextMoveToPoint(context,    myStartPoint.x, myStartPoint.y);
        //把move的点全部加入　数组
        for (int i=0; i<[myallpoint count]-1; i++)
        {
            CGPoint myEndPoint=  [[myallpoint objectAtIndex:i+1] CGPointValue];
            CGContextAddLineToPoint(context, myEndPoint.x,   myEndPoint.y);
        }
        
        //-------------------------------------------
        //绘制画笔颜色
        CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
        CGContextSetFillColorWithColor (context,  [[UIColor redColor] CGColor]);
        //-------------------------------------------
        //绘制画笔宽度
        CGContextSetLineWidth(context, 1);
        //把数组里面的点全部画出来
        CGContextStrokePath(context);
    }
}

//===========================================================
//初始化
//===========================================================
-(void)Introductionpoint1
{
    NSLog(@"in init allPoint");
    myallpoint=[[NSMutableArray alloc] initWithCapacity:10];
}
//===========================================================
//把画过的当前线放入　存放线的数组
//===========================================================
-(void)Introductionpoint2
{
    [myallline addObject:myallpoint];
}
-(void)Introductionpoint3:(CGPoint)sender
{
    NSValue* pointvalue=[NSValue valueWithCGPoint:sender];
    [myallpoint addObject:pointvalue ];
}

//===========================================================
//清屏按钮
//===========================================================
-(void)myalllineclear
{
    if ([myallline count]>0)
    {
        [myallline removeAllObjects];
        [myallpoint removeAllObjects];
        myallline=[[NSMutableArray alloc] initWithCapacity:10];
        [self setNeedsDisplay];
    }
}
//===========================================================
//撤销
//===========================================================
-(void)myLineFinallyRemove
{
    if ([myallline count]>0)
    {
        [myallline  removeLastObject];
        
        [myallpoint removeAllObjects];
    }
    [self setNeedsDisplay];
}
@end