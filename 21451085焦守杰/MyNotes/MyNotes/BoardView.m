//
//  BoardView.m
//  MyNotes
//
//  Created by 焦守杰 on 14/11/23.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "BoardView.h"
#import "Line.h"
@implementation BoardView
-(id)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        _lineArray=[[NSMutableArray alloc]init];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineJoin(context,kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    for(int i=0;i<_lineArray.count;i++){
        Line *ll=[_lineArray objectAtIndex:i];
        if([ll getLength]>0){
            CGContextBeginPath(context);
            CGPoint startPoint=[ll getPointAt:0];
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
            for(int j=1;j<[ll getLength];j++){
                CGPoint p=[ll getPointAt:j];
                CGContextAddLineToPoint(context, p.x, p.y);
//                NSLog(@"%d %d ",p.x,p.y);
            }
            CGContextSetStrokeColorWithColor(context, [[self  parseColor:ll.color] CGColor]);
            CGContextSetLineWidth(context, ll.size);
            CGContextStrokePath(context);
            
        }
    }
    


}
-(UIColor*)parseColor:(int)c{
    switch (c) {
        case 0:
            return [UIColor redColor];
            break;
        case 1:
            return [UIColor orangeColor];
            break;
        case 2:
            return [UIColor yellowColor];
            break;
        case 3:
            return [UIColor greenColor];
            break;
        case 4:
            return [UIColor cyanColor];
            break;
        case 5:
            return [UIColor blueColor];
            break;
        case 6:
            return [UIColor purpleColor];
            break;
        default:return [UIColor whiteColor];
            break;
    }
}
-(void)clear{
    [_lineArray removeAllObjects];
    [self setNeedsDisplay];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    l=[[Line alloc]initWithColor:_color andSize:_size];
    [self addPointToLine:touches];
    [_lineArray addObject:l];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self addPointToLine:touches];
    
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
-(void)addPointToLine:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [l addPoint:point];
    [self setNeedsDisplay];
}

@end
