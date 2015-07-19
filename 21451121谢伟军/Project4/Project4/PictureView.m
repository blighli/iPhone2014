//
//  PictureView.m
//  Project4
//
//  Created by xvxvxxx on 14/11/24.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "PictureView.h"

@implementation PictureView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.currentColor = [UIColor redColor];
    }
    self.pointArray = [NSMutableArray array];
    self.lineArray = [NSMutableArray array];
    return self;
}

#pragma mark - my drawRect
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 4.0);
    //线条拐角样式，设置为平滑
    CGContextSetLineJoin(context,kCGLineJoinRound);
    //线条开始样式，设置为平滑
    CGContextSetLineCap(context, kCGLineCapRound);

    CGContextSetStrokeColorWithColor(context, self.currentColor.CGColor);
    //用于描绘过去的线路
    for (NSArray *line in self.lineArray) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, [[line objectAtIndex:0]CGPointValue].x, [[line objectAtIndex:0]CGPointValue].y);
        for (NSValue *point in line) {
            CGPoint temp = [point CGPointValue];
            CGContextAddLineToPoint(context, temp.x, temp.y);
        }
        CGContextStrokePath(context);
    }
    //用于描绘实时线路，如果没有下面的if语句，将会在touch结束之后才有线路
    if ([self.pointArray count]>0) {
        CGContextBeginPath(context);
        CGPoint myStartPoint=[[self.pointArray objectAtIndex:0]CGPointValue];
        CGContextMoveToPoint(context, myStartPoint.x, myStartPoint.y);
        for (NSValue *point in self.pointArray) {
            CGPoint temp=[point CGPointValue];
            CGContextAddLineToPoint(context, temp.x,temp.y);
        }
        CGContextStrokePath(context);
    }
    
}


-(void)addLine{
    NSArray *tempArry = [NSArray arrayWithArray:self.pointArray];
    [self.lineArray addObject:tempArry];
}

#pragma mark - Touch Handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.pointArray removeAllObjects];
    UITouch *touch = [touches anyObject];
    self.firstTouchLocation = [touch locationInView:self];
    [self.pointArray addObject:[NSValue valueWithCGPoint:self.firstTouchLocation]];
//    self.lastTouchLocation = [touch locationInView:self];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint tempPoint = [touch locationInView:self];
    NSString *tempString = NSStringFromCGPoint(tempPoint);
    NSLog(@"%@",tempString);
    [self.pointArray addObject:[NSValue valueWithCGPoint:tempPoint]];
    self.lastTouchLocation = [touch locationInView:self];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.lastTouchLocation = [touch locationInView:self];
    [self addLine];
    [self setNeedsDisplay];
}

-(BOOL)writeToFile:(NSString*)filePath {
    [NSKeyedArchiver archiveRootObject:self.lineArray toFile:filePath];
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

-(void)readFromFile:(NSString*) filePath {
    self.lineArray = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    [self setNeedsDisplay];
}

@end
