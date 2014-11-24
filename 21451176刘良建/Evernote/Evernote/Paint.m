//
//  Paint.m
//  Evernote
//
//  Created by JANESTAR on 14-11-22.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import "Paint.h"

@implementation Paint
@synthesize lineArray=_lineArray;

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        
        self.lineArray=[NSMutableArray arrayWithCapacity:1];
        UIButton * button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame=CGRectMake((frame.size.width-100)/2, frame.size.height-50, 100, 30);
        [button setTitle:@"撤销" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(undo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    return self;
}

-(void)undo:(UIButton*)button{
    [_lineArray removeLastObject];
    [self setNeedsDisplay];

}

-(void)drawRect:(CGRect)rect{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    for(int i=0;i<[_lineArray count];i++){
        NSMutableArray *pointArray=[_lineArray objectAtIndex:i];
        for(int j=0;j<(int)pointArray.count-1;j++){
            NSValue* firstPointValue=[pointArray objectAtIndex:j];
            NSValue* secondPointValue=[pointArray objectAtIndex:j+1];
            CGPoint firstPoint=[firstPointValue CGPointValue];
            CGPoint secondPoint=[secondPointValue CGPointValue];
            
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
            
            
        }
        
    }

    CGContextStrokePath(context);

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSMutableArray* pointArray=[NSMutableArray arrayWithCapacity:1];
    [_lineArray addObject:pointArray];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    //NSLog(@"point=%@",NSStringFromCGPoint(point));
    NSMutableArray* pointArray=[_lineArray lastObject];
    NSValue* pointValue=[NSValue valueWithCGPoint:point];
    [pointArray addObject:pointValue];
    [self setNeedsDisplay];
}



@end
