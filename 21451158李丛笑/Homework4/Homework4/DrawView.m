//
//  DrawView.m
//  Homework4
//
//  Created by 李丛笑 on 14/12/22.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "DrawView.h"
#import "DrawViewModel.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
@interface DrawView()

@property (assign, nonatomic) CGMutablePathRef path;
@property (strong, nonatomic) NSMutableArray *pathArray;
@property (assign, nonatomic) BOOL isHavePath;
@end

@implementation DrawView

NSMutableArray *colorArray;

NSMutableArray *removeColorArray;

NSMutableArray *ponitArray;

NSMutableArray *lineArray;

NSMutableArray *removedArray;

CGPoint PointPath;

//float lineWidthArray[4] = {10.0,20.0,30.0,40.0};

float lineWidthArray[4] = {15.0,20.0,25.0,30.0};

NSMutableArray *removeWidthArray;

NSMutableArray  *WidthArray;

int colorCount;

int widthCount;

NSMutableArray  *colors;

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
        colors  = [[NSMutableArray alloc]initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blackColor],[UIColor whiteColor], nil];
        //colorArray = [[NSMutableArray alloc]initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blackColor], nil];
        colorArray = [[NSMutableArray alloc]init];
        // colorArray = [[NSMutableArray alloc]arrayByAddingObjectsFromArray:colors];
        removeColorArray = [[NSMutableArray alloc]init];
        removedArray =  [[NSMutableArray alloc]init];
        removeWidthArray =  [[NSMutableArray alloc]init];;
        ponitArray =  [[NSMutableArray alloc]init];;
        lineArray = [[NSMutableArray alloc]init];
        WidthArray =  [[NSMutableArray alloc]init];
        colorCount = 0;
        widthCount = 0;
//        [self setColor:<#(int)#>]
    
      
    }
    return self;
}

-(void)setColor:(int)color
{
    colorCount = color;
}

-(void)setWidth:(int)width
{
    widthCount = width;
}

-(void)addPoint:(CGPoint)Point
{
    NSString *PointA = NSStringFromCGPoint(Point);
    [ponitArray addObject:PointA];
}



-(void)addLine
{
    [WidthArray addObject:[[NSNumber alloc]initWithInt:widthCount]];
    [colorArray addObject:[[NSNumber alloc]initWithInt:colorCount]];
    
    // [[lineArray addObject:[NSArray arrayWithArray:ponitArray]]];
    [lineArray addObject:[[NSArray alloc]initWithArray:ponitArray]];
    ponitArray = [[NSMutableArray alloc]init];
    
}
-(void)deleteTheLast
{
    if ([lineArray count]) {
        [removedArray addObject:[lineArray lastObject]];
        [lineArray removeLastObject];
    }
    if ([colorArray count]) {
        [removeColorArray addObject:[colorArray lastObject]];
        [colorArray removeLastObject];
    }
    if ([WidthArray count]) {
        [removeWidthArray addObject:[WidthArray lastObject]];
        [WidthArray removeLastObject];
    }
    [self setNeedsDisplay];
}
// Back to the last step
-(void)BackToTheLast
{
    if ([lineArray count]) {
        [removedArray addObject:[lineArray lastObject]];
        [lineArray removeLastObject];
    }
    if ([WidthArray count]) {
        [removeWidthArray addObject:[WidthArray lastObject]];
        [WidthArray removeLastObject];
    }
    if ([colorArray count]) {
        [removeColorArray addObject:[colorArray lastObject]];
        [colorArray removeLastObject];
    }
    // Redraw the graphics and Display
    [self setNeedsDisplay];
}
// clean the Screen
-(void)clearAll
{
    // remove all the data of  Arrays
    [colorArray removeAllObjects];
    [WidthArray removeAllObjects];
    [removeColorArray removeAllObjects];
    [removedArray removeAllObjects];
    [removeWidthArray removeAllObjects];
    [ponitArray removeAllObjects];
    [lineArray removeAllObjects];
    widthCount = 0;
    colorCount = 0;
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touchPoint = [touches anyObject];
    
    PointPath = [touchPoint locationInView:self];
    NSString *onePoint  = NSStringFromCGPoint(PointPath);
    [ponitArray addObject:onePoint];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self addLine];
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    //  before we start to draw ,we must do some setting   for example   get the context and set the patterns .....
    //get the current context
    CGContextRef CGcontext = UIGraphicsGetCurrentContext();
    CGContextBeginPath(CGcontext);
    CGContextSetLineJoin(CGcontext, kCGLineJoinRound);
    CGContextSetLineWidth(CGcontext,  lineWidthArray[0]);
    CGContextSetLineJoin(CGcontext, kCGLineJoinRound);
    
    // Draw the line in the lineArray  if the lineArray contains line data  draw it , or
    // draw the current line
    
    NSInteger countofLine = 0;
    countofLine = [lineArray count];
    if (countofLine) {
        for (int i = 0; i<countofLine; i++) {
            // set the line attributes
            
            // get the line width from the WidthArray
            NSNumber *width = [WidthArray objectAtIndex:i];
            int LineWidth = [width intValue];
            float widthOfLine = lineWidthArray[LineWidth];
            
            // get the line color from the colorArray
            NSNumber *colorIndex = [colorArray objectAtIndex:i];
            int ColorOfIndex  = [colorIndex intValue];
            UIColor *lineColor = [colors objectAtIndex:ColorOfIndex];
            //UIColor *lineColor = [colorArray objectAtIndex:ColorOfIndex];
            // set the line color
            CGContextSetStrokeColorWithColor(CGcontext, [lineColor CGColor]);
            
            //set the line width
            CGContextSetLineWidth(CGcontext, widthOfLine);
            
            // draw line now
            NSArray *CurrentArray = [NSArray arrayWithArray:[lineArray objectAtIndex:i]];
            
            if ([CurrentArray count])
            {
                CGContextBeginPath(CGcontext);
                CGPoint FromPonit = CGPointFromString([CurrentArray objectAtIndex:0]);
                CGContextMoveToPoint(CGcontext, FromPonit.x, FromPonit.y);
                
                NSInteger linecount  =0;
                linecount = [CurrentArray count];
                for (int j = 0; j<linecount-1;j++)
                {
                    CGPoint topoint = CGPointFromString([CurrentArray objectAtIndex:j+1]);
                    CGContextAddLineToPoint(CGcontext, topoint.x , topoint.y);
                }
                //save
                CGContextStrokePath(CGcontext);
            }
        }
    }
    // draw current line
    if ([ponitArray count]) {
        
        //set the color and width
        UIColor *lineColor=[colors objectAtIndex:colorCount];
        //UIColor *lineColor=[colorArray objectAtIndex:colorCount];
        float width=lineWidthArray[widthCount];
        CGContextSetStrokeColorWithColor(CGcontext,[lineColor CGColor]);
        CGContextSetLineWidth(CGcontext, width);
        
        //draw the line
        CGContextBeginPath(CGcontext);
        CGPoint FromPonit = CGPointFromString([ponitArray objectAtIndex:0]);
        CGContextMoveToPoint(CGcontext, FromPonit.x, FromPonit.y);
        
        NSInteger linecount  =0;
        linecount = [ponitArray count];
        for (int j = 0; j<linecount-1;j++)
        {
            CGPoint topoint = CGPointFromString([ponitArray objectAtIndex:j+1]);
            CGContextAddLineToPoint(CGcontext, topoint.x , topoint.y);
        }
        
        //save
        CGContextStrokePath(CGcontext);
        
    }
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
