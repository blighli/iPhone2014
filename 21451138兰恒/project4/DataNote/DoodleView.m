//
//  DoodleView.m
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import "DoodleView.h"

@implementation DoodleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if(!_lineArray)
        {
            _lineArray = [NSMutableArray arrayWithCapacity:1];
        }
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextSetLineWidth(context, 2.0);
    
    for(int i =0;i < [_lineArray count];i++)
    {
        NSMutableArray *pointArray = [_lineArray objectAtIndex:i];
        for (int j = 0; j < (int)[pointArray count] - 1; j++)
        {
            NSValue *fristpointVal = [pointArray objectAtIndex:j];
            NSValue *secondpointVal = [pointArray objectAtIndex:j+1];
            
            CGPoint fristPoint = [fristpointVal CGPointValue];
            CGPoint secondPoint = [secondpointVal CGPointValue];
            
            CGContextMoveToPoint(context, fristPoint.x, fristPoint.y);
            
            CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
            
            
        }
    }
    CGContextStrokePath(context);
    // Drawing code
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *pointArray = [NSMutableArray arrayWithCapacity:1];
    [_lineArray addObject:pointArray];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSValue * avalue = [NSValue valueWithCGPoint:point];
    NSMutableArray *pointArray = [_lineArray lastObject];
    [pointArray addObject:avalue];
    
    [self setNeedsDisplay];
}

-(void) undo
{
    [_lineArray removeAllObjects];
    [self setNeedsDisplay];
}
@end
