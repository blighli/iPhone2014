//
//  PaintView.m
//  noteprotype
//
//  Created by zhou on 14/11/24.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "PaintView.h"

@interface PaintView ()

@end

@implementation PaintView

CGContextRef Context;

CGPoint firstTouch, lastTouch, prevTouch;
CGRect currentRect;

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self)
    {
        self.color = [UIColor blackColor];
    }
    return self;
}


- (void)setSelectedColor:(UIColor *)color
{
    self.color = color;
}

- (CGRect)currentRect
{
    return CGRectMake(firstTouch.x, firstTouch.y, lastTouch.x - firstTouch.x, lastTouch.y - firstTouch.y);
}

#pragma mark - Touch Handling
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch     = [touches anyObject];
    firstTouch = [touch locationInView:self];
    prevTouch = firstTouch;

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    lastTouch = [touch locationInView:self];
    
    [self drawAtRealTime];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    lastTouch = [touch locationInView:self];

    [self drawAtRealTime];
}

// draw the image of memory to the view;
- (void)drawRect:(CGRect)rect
{
    if (self.image!=nil) {
        [self.image drawAtPoint:CGPointZero];
    }
    
}

- (void)drawAtRealTime
{
    
    UIGraphicsBeginImageContext(self.bounds.size);
    Context = UIGraphicsGetCurrentContext();
    
    [self.image drawInRect:CGRectMake(0.0, 0.0, self.image.size.width,self.image.size.height)];
    
    CGContextSetStrokeColorWithColor(Context, self.color.CGColor);
    CGContextSetLineWidth(Context, 1.0);
    CGContextSetShouldAntialias(Context, YES);

    CGContextMoveToPoint(Context, prevTouch.x, prevTouch.y);
    CGContextAddLineToPoint(Context, lastTouch.x, lastTouch.y);
    CGContextStrokePath(Context);
    prevTouch = lastTouch;

    self.image = UIGraphicsGetImageFromCurrentImageContext();

    [self setNeedsDisplay];
}

@end
