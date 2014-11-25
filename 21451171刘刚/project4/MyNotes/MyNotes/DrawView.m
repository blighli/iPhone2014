//
//  DrawView.m
//  MyNotes
//
//  Created by liug on 14-11-23.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "DrawView.h"
#import <QuartzCore/QuartzCore.h>
@implementation DrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineArray=[NSMutableArray arrayWithCapacity:1];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame=CGRectMake(0, 0, 60, 30);
        [button setTitle:@"undo" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(undo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}
-(void)undo:(UIButton *)button{
    [_lineArray removeLastObject];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    for(int i=0;i<[_lineArray count];i++){
        NSMutableArray *pointArray=[_lineArray objectAtIndex:i];
        for(int j=0;j<(int)[pointArray count]-1;j++){
            NSValue *firstPointValue=[pointArray objectAtIndex:j];
            NSValue *secondPointValue=[pointArray objectAtIndex:j+1];
            
            CGPoint firstPoint=[firstPointValue CGPointValue];
            CGPoint secondPoint=[secondPointValue CGPointValue];
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
        }
    }
    CGContextStrokePath(context);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSMutableArray *pointArray=[NSMutableArray arrayWithCapacity:1];
    [_lineArray addObject:pointArray];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    NSValue *pointValue=[NSValue valueWithCGPoint:point];
    //NSLog(@"point=%@",NSStringFromCGPoint(point));
    NSMutableArray *pointArray=[_lineArray lastObject];
    [pointArray addObject:pointValue];
    [self setNeedsDisplay];
}
//-(UIImage *)getImageFromView:(UIView *)myView{
//    UIGraphicsBeginImageContext(myView.bounds.size);
//    [myView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
- (BOOL)getImageFromView:(NSString *)path {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
}

@end
