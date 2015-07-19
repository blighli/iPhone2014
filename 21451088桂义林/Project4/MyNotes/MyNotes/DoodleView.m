//
//  DoodleView.m
//  MyNotes
//
//  Created by YilinGui on 14-11-22.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "DoodleView.h"

@implementation DoodleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.lineArray = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置画笔颜色
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
    // 设置画笔的粗细
    CGContextSetLineWidth(context, 2.0);
 
    for (int i = 0; i < [self.lineArray count]; ++i) {
        NSMutableArray *pointArray = [self.lineArray objectAtIndex:i];
        for (int j = 0; j < (int)[pointArray count] - 1; ++j) {
            NSValue *firstPointValue = [pointArray objectAtIndex:j];
            NSValue *secondPointValue = [pointArray objectAtIndex:j + 1];
            
            CGPoint firstPoint = [firstPointValue CGPointValue];
            CGPoint secondPoint = [secondPointValue CGPointValue];
            // 把笔触移动到一个点
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            // 笔触和另一个点添加连线
            CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
        }
    }
    
    // 真正的绘制
    CGContextStrokePath(context);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSMutableArray *pointArray = [NSMutableArray arrayWithCapacity:1];
    [[self lineArray] addObject:pointArray];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    //NSLog(@"point = %@", NSStringFromCGPoint(point));
    
    NSMutableArray *pointArray = [self.lineArray lastObject];
    NSValue *pointValue = [NSValue valueWithCGPoint:point];
    [pointArray addObject:pointValue];
    
    // 重绘界面
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (BOOL)saveToPNGFile:(NSString *)path {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
}

@end
