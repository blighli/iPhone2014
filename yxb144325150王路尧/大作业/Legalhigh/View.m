//
//  View.m
//  Legalhigh
//
//  Created by 王路尧 on 14/12/10.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import "View.h"

@interface View ()
{
    CGPoint oldPoint;
    CGPoint curPoint;
    BOOL didCreat;
}
@property(nonatomic,strong)NSMutableArray *paths;
@end

@implementation View

-(NSMutableArray *)paths
{
    if (_paths==nil) {
        _paths=[NSMutableArray array];
    }
    return _paths;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    didCreat=YES;
    UITouch  *touch=[touches anyObject];
    oldPoint=[touch locationInView:[touch view]];
    curPoint=[touch locationInView:[touch view]];
    
    [self performSelector:@selector(createTextFiled) withObject:nil afterDelay:1.5f];
    
    
    CGPoint starPoint=[touch locationInView:touch.view];
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path setLineWidth:5];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path moveToPoint:starPoint];
    [self.paths addObject:path];
    [self becomeFirstResponder];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    didCreat=NO;
}
- (void)createTextFiled
{
    if (curPoint.x==oldPoint.x&&curPoint.y==oldPoint.y&&didCreat) {
        CGRect rct=CGRectMake(curPoint.x, curPoint.y, 100, 30);
        UITextField *bianjikuang=[[UITextField alloc]initWithFrame:rct];
        [bianjikuang setBorderStyle:UITextBorderStyleRoundedRect];
        [self addSubview:bianjikuang];
        bianjikuang.backgroundColor=[UIColor clearColor];
        bianjikuang.textColor=[UIColor redColor];
        bianjikuang.delegate=self;
        
       // [bianjikuang addTarget:self action:@selector(endText:) forControlEvents:UITextFieldTextDidEndEditingNotification];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)endText:(id)sender
{
    [sender resignFirstResponder];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    curPoint=[touch locationInView:[touch view]];
    
    CGPoint movePoint=[touch locationInView:touch.view];
    UIBezierPath *currentPath=[self.paths lastObject];
    [currentPath addLineToPoint:movePoint];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    
    for (UIBezierPath *path in self.paths) {
        [path stroke];
    }
}

-(void)clearView
{
    
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

-(void)backView
{
    
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
@end

