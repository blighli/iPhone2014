//
//  MyView.m
//  mynote
//
//  Created by Devon on 14/11/20.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import "MyView.h"

@implementation MyView
//保存线条颜色
static NSMutableArray *colorArray;
//每次触摸结束前经过的点，形成线的点数组
static NSMutableArray *pointArray;
//每次触摸结束后的线数组
static NSMutableArray *lineArray;
//线条宽度的数组
static float lineWidthArray[4]={10.0,20.0,30.0,40.0};
//正常存储的线条宽度的数组
static NSMutableArray *WidthArray;
//确定颜色的值，将颜色计数的值存到数组里默认为0，即为绿色
static int colorCount;
//确定宽度的值，将宽度计数的值存到数组里默认为0，即为10
static int widthCount;
//保存颜色的数组
static NSMutableArray *colors;
- (id)init
{
    self = [super init];
    if (self) {
     
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化颜色数组，将用到的颜色存储到数组里
        colors=[[NSMutableArray alloc]initWithObjects:[UIColor blueColor],[UIColor redColor],[UIColor greenColor],[UIColor yellowColor], nil];
        WidthArray=[[NSMutableArray alloc]init];
        pointArray=[[NSMutableArray alloc]init];
        lineArray=[[NSMutableArray alloc]init];
        colorArray=[[NSMutableArray alloc]init];
        //颜色和宽度默认都取当前数组第0位为默认值
        colorCount=0;
        widthCount=0;
        // Initialization code
    }
    return self;
}
//给界面按钮操作时获取tag值作为width的计数。来确定宽度，颜色同理
-(void)setlineWidth:(NSInteger)width{
    widthCount=width;
}
-(void)setLineColor:(NSInteger)color{
    colorCount=color;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //获取当前上下文，
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 10.0f);
    //线条拐角样式，设置为平滑
    CGContextSetLineJoin(context,kCGLineJoinRound);
    //线条开始样式，设置为平滑
    CGContextSetLineCap(context, kCGLineJoinRound);
    if ([lineArray count]>0) {
        for (int i=0; i<[lineArray count]; i++) {
            NSArray * array=[NSArray arrayWithArray:[lineArray objectAtIndex:i]];
            if ([array count]>0) {
                CGContextBeginPath(context);
                CGPoint myStartPoint=CGPointFromString([array objectAtIndex:0]);
                CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
                for (int j=0; j<[array count]-1; j++) {
                    CGPoint myEndPoint=CGPointFromString([array objectAtIndex:j+1]);
                    CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
                }
                NSNumber *num=[colorArray objectAtIndex:i];
                int count=[num intValue];
                UIColor *lineColor=[colors objectAtIndex:count];
                NSNumber *wid=[WidthArray objectAtIndex:i];
                int widthc=[wid intValue];
                float width=lineWidthArray[widthc];
                CGContextSetStrokeColorWithColor(context,[lineColor CGColor]);
                CGContextSetLineWidth(context, width);
                CGContextStrokePath(context);
            }
        }
    }
    if ([pointArray count]>0)
    {
        CGContextBeginPath(context);
        CGPoint myStartPoint=CGPointFromString([pointArray objectAtIndex:0]);
        CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
        
        for (int j=0; j<[pointArray count]-1; j++) {
            CGPoint myEndPoint=CGPointFromString([pointArray objectAtIndex:j+1]);
            CGContextAddLineToPoint(context, myEndPoint.x,myEndPoint.y);
        }
        UIColor *lineColor=[colors objectAtIndex:colorCount];
        float width=lineWidthArray[widthCount];
        CGContextSetStrokeColorWithColor(context,[lineColor CGColor]);
        CGContextSetLineWidth(context, width);
        CGContextStrokePath(context);
    }
}

-(void)addLA {
    NSNumber *wid=[[NSNumber alloc]initWithInt:widthCount];
    NSNumber *num=[[NSNumber alloc]initWithInt:colorCount];
    [colorArray addObject:num];
    [WidthArray addObject:wid];
    NSArray *array=[NSArray arrayWithArray:pointArray];
    [lineArray addObject:array];
    pointArray=[[NSMutableArray alloc]init];
}

#pragma mark -
static CGPoint MyBeganpoint;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch=[touches anyObject];
	MyBeganpoint=[touch locationInView:self];
    NSString *sPoint=NSStringFromCGPoint(MyBeganpoint);
    [pointArray addObject:sPoint];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self addLA];
    NSLog(@"touches end");
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touches Canelled");
}

-(void)clear {
    colorCount=0;
    [colorArray removeAllObjects];
    [lineArray removeAllObjects];
    [pointArray removeAllObjects];
    widthCount=0;
    [WidthArray removeAllObjects];
    [self setNeedsDisplay];
}
@end
