//
//  QuartzView.m
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "QuartzView.h"

@implementation QuartzView

//保存线条颜色
static NSMutableArray *colorArray;
//每次触摸结束前经过的点，形成线的点数组
static NSMutableArray *pointArray;
//每次触摸结束后的线数组
static NSMutableArray *lineArray;
//正常存储的线条宽度的数组
static NSMutableArray *WidthArray;
//确定颜色的值，将颜色计数的值存到数组里默认为0，即为红色
static int colorCount;
//确定宽度的值，默认为5
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
        colors=[[NSMutableArray alloc]initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blackColor],[UIColor brownColor],[UIColor whiteColor], nil];
        WidthArray=[[NSMutableArray alloc]init];
        pointArray=[[NSMutableArray alloc]init];
        lineArray=[[NSMutableArray alloc]init];
        colorArray=[[NSMutableArray alloc]init];
        //颜色默认都取红色
        colorCount=0;
        //宽度默认5
        widthCount=5;
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
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    //线条拐角样式，设置为平滑
    CGContextSetLineJoin(context,kCGLineJoinRound);
    //线条开始样式，设置为平滑
    CGContextSetLineCap(context, kCGLineCapRound);
    
    //查看lineArray数组里是否有线条，有就将之前画的重绘，没有只画当前线条
    if ([lineArray count]>0) {
        for (int i = 0; i<[lineArray count]; i++) {
            NSArray *array = [NSArray arrayWithArray:[lineArray objectAtIndex:i]];
            if ([array count]>0) {
                CGContextBeginPath(context);
                CGPoint myStartPoint = CGPointFromString([array objectAtIndex:0]);
                CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
                
                for (int j = 0; j<[array count]-1; j++) {
                    CGPoint myEndPoint = CGPointFromString([array objectAtIndex:j+1]);
                    CGContextAddLineToPoint(context, myEndPoint.x, myEndPoint.y);
                }
                //获取colorArray数组里的要绘制线条的颜色
                NSNumber *num = [colorArray objectAtIndex:i];
                int count = [num intValue];
                UIColor *lineColor = [colors objectAtIndex:count];
                //获取WidthArray数组里的要绘制线条的宽度
                NSNumber *wid=[WidthArray objectAtIndex:i];
                int width=[wid intValue];
                //设置线条的颜色，要取uicolor的CGColor
                CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
                //设置线条宽度
                CGContextSetLineWidth(context, width);
                //保存自己画的
                CGContextStrokePath(context);
            }
        }
    }
    
    //画当前的线
    if ([pointArray count]>0) {
        CGContextBeginPath(context);
        CGPoint myStartPoint = CGPointFromString([pointArray objectAtIndex:0]);
        CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
        
        for (int k = 0; k<[pointArray count]-1; k++) {
            CGPoint myEndPoint = CGPointFromString([pointArray objectAtIndex:k+1]);
            CGContextAddLineToPoint(context, myEndPoint.x, myEndPoint.y);
        }
        UIColor *lineColor = [colors objectAtIndex:colorCount];
        CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
        CGContextSetLineWidth(context, widthCount);
        CGContextStrokePath(context);
    }
}

//在touch结束前将获取到的点，放到pointArray里
- (void)addPA:(CGPoint)nPoint
{
    NSString *sPoint = NSStringFromCGPoint(nPoint);
    [pointArray addObject:sPoint];
}

//在touchend时，将已经绘制的线条的颜色，宽度，线条线路保存到数组里
- (void)addLA
{
    NSNumber *wid = [[NSNumber alloc] initWithInt:widthCount];
    [WidthArray addObject:wid];
    NSNumber *num=[[NSNumber alloc]initWithInt:colorCount];
    [colorArray addObject:num];
    NSArray *array = [NSArray arrayWithArray:pointArray];
    [lineArray addObject:array];
    pointArray = [[NSMutableArray alloc] init];
}

#pragma mark -
static CGPoint MyBeganPoint;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    MyBeganPoint = [touch locationInView:self];
    NSString *sPoint = NSStringFromCGPoint(MyBeganPoint);
    [pointArray addObject:sPoint];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self addLA];
}

- (void)clear
{
    [colorArray removeAllObjects];
    [pointArray removeAllObjects];
    [lineArray removeAllObjects];
    [WidthArray removeAllObjects];
    colorCount = 0;
    widthCount = 5;
    [self setNeedsDisplay];
}


@end
