//
//  DrawBoardView.m
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import "DrawBoardView.h"
#import <math.h>

@implementation DrawBoardView
{
    NSMutableArray* _drawStrokes;
}

-(BOOL)writeToFile:(NSString*)filePath {
    NSLog(@"archiveRootObject return %d", [NSKeyedArchiver archiveRootObject:_drawStrokes toFile:filePath]);
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

-(void)readFromFile:(NSString*) filePath {
    _drawStrokes = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
     [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(_drawStrokes == nil) {
        _drawStrokes = [NSMutableArray new];
    }
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    DrawStroke* stroke = [[DrawStroke alloc] initWithStartCGPoint:touchPoint];
    [_drawStrokes addObject:stroke];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    DrawStroke* stroke = [_drawStrokes lastObject];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    [stroke addCGPoint:touchPoint];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    DrawStroke* stroke = [_drawStrokes lastObject];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    [stroke addCGPoint:touchPoint];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, self.drawColor.CGColor);
    for(DrawStroke *stroke in _drawStrokes) {
        [stroke drawContext:context];
    }
    CGContextStrokePath(context);
}


@end

@implementation DrawPoint

-(instancetype) initWithCGPoint:(CGPoint)point {
    self = [super init];
    self.point = point;
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    CGFloat x = (CGFloat)[aDecoder decodeDoubleForKey:@"x"];
    CGFloat y = (CGFloat)[aDecoder decodeDoubleForKey:@"y"];
    self.point = CGPointMake(x, y);
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:(double)self.point.x forKey:@"x"];
    [aCoder encodeDouble:(double)self.point.y forKey:@"y"];
}

@end


@implementation DrawStroke

-(instancetype)initWithStartCGPoint:(CGPoint)point {
    self = [super init];
    self.pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(self.pathRef, NULL, point.x, point.y);
    self.drawPoints = [NSMutableArray new];
    [self.drawPoints addObject:[[DrawPoint alloc] initWithCGPoint:point]];
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.pathRef = CGPathCreateMutable();
    self.drawPoints = [aDecoder decodeObjectForKey:@"drawPoints"];
    DrawPoint *startDrawPoint = [self.drawPoints objectAtIndex:0];
    CGPoint startPoint = CGPointMake(startDrawPoint.point.x, startDrawPoint.point.y);
    CGPathMoveToPoint(self.pathRef, NULL, startPoint.x, startPoint.y);
    for(NSInteger i = 1; i < [self.drawPoints count]; ++i) {
        DrawPoint *drawPoint = [self.drawPoints objectAtIndex:i];
        CGPoint point = CGPointMake(drawPoint.point.x, drawPoint.point.y);
        CGPathAddLineToPoint(self.pathRef, NULL, point.x, point.y);
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.drawPoints forKey:@"drawPoints"];
}

-(void)addCGPoint:(CGPoint)point {
    CGPathAddLineToPoint(self.pathRef, NULL, point.x, point.y);
    [self.drawPoints addObject:[[DrawPoint alloc] initWithCGPoint:point]];
}

-(void)drawContext:(CGContextRef)context {
    CGContextAddPath(context, self.pathRef);
}

-(void)dealloc{
    CGPathRelease(self.pathRef);
}

@end


