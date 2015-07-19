//
//  DrawingViewController.m
//  MyNotes
//
//  Created by 杨长湖 on 14/11/26.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import "DrawingViewController.h"

@interface DrawingViewController ()

@end

@implementation DrawingViewController

@synthesize lastPoint;
@synthesize drawImage;
@synthesize mouseSwiped;
@synthesize currentColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    drawImage = [[UIImageView alloc] initWithImage:nil];
    drawImage.frame = self.view.frame;
    [self.view addSubview:drawImage];
    mouseMoved = 0;
    lineSize = 2;
    currentColor = [UIColor blackColor];
    [self colorHidden];
    self.sliderValue.hidden = YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake) {
        drawImage.image = nil;
        return;
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 2) {
        drawImage.image = nil;
        return;
    }
    lastPoint = [touch locationInView:self.view];
    //lastPoint.y -= 10;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    //currentPoint.y -= 10;
    UIGraphicsBeginImageContext(self.view.frame.size);
    [drawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineSize);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), currentColor.CGColor);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    lastPoint = currentPoint;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch tapCount] == 2) {
        drawImage.image = nil;
        return;
    }
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [drawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineSize);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), currentColor.CGColor);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//颜色
- (IBAction)setColors:(id)sender {
    self.sliderValue.hidden = YES;
    if (self.blueH.hidden == YES)
        [self colorShow];
    else
        [self colorHidden];
}
- (void) colorHidden{
    self.blackH.hidden = YES;
    self.redH.hidden = YES;
    self.yellowH.hidden = YES;
    self.greenH.hidden = YES;
    self.blueH.hidden = YES;
}
- (void)colorShow{
    self.blackH.hidden = NO;
    self.redH.hidden = NO;
    self.yellowH.hidden = NO;
    self.greenH.hidden = NO;
    self.blueH.hidden = NO;
}
- (IBAction)bleck:(id)sender {
    currentColor = [UIColor blackColor];
}
- (IBAction)red:(id)sender {
    currentColor = [UIColor redColor];
}
- (IBAction)yellow:(id)sender{
    currentColor = [UIColor yellowColor];
}
- (IBAction)green:(id)sender{
    currentColor = [UIColor greenColor];
}
- (IBAction)blue:(id)sender{
    currentColor = [UIColor blueColor];
}
//笔触
- (IBAction)pointSize:(id)sender {
    [self colorHidden];
    if (self.sliderValue.hidden == YES)
        self.sliderValue.hidden = NO;
    else
        self.sliderValue.hidden = YES;
    
}
- (IBAction)sliderChanged:(id)sender {
    NSLog(@"----%f",self.sliderValue.value);
    lineSize = self.sliderValue.value;
}
@end
