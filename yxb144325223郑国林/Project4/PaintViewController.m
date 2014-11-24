//
//  PaintViewController.m
//  Project4
//
//  Created by CST-112 on 14-11-19.
//  Copyright (c) 2014年 CST-112. All rights reserved.

#import "PaintViewController.h"
#import "Constants.h"
#import "QuartzView.h"

@interface PaintViewController ()

@end

@implementation PaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISegmentedControl *control;
//    control.frame = CGRectMake(10.0, 100, 200, 50);
    array=[[NSMutableArray alloc]initWithCapacity:10];
    [(QuartzView *)self.view setShapeArray:array];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)changeColor:(id)sender {
    UISegmentedControl *control=sender;
    NSInteger index=[control selectedSegmentIndex];
    
    QuartzView *funView=(QuartzView *)self.view;
    switch (index) {
        case kRedColorTab:
            funView.currentColor=[UIColor redColor];
            funView.useRandomColor=NO;
            break;
        case kBlueColorTab:
            funView.currentColor=[UIColor blueColor];
            funView.useRandomColor=NO;
            break;
        case kYellowColorTab:
            funView.currentColor=[UIColor yellowColor];
            funView.useRandomColor=NO;
            break;
        case kGreenColorTab:
            funView.currentColor=[UIColor greenColor];
            funView.useRandomColor=NO;
            break;
        case kRandomColorTab:
            funView.useRandomColor=YES;
            break;
        default:
            break;
    }
}

- (IBAction)changeShape:(id)sender {
    UISegmentedControl *control=sender;
    [(QuartzView *)self.view setShapeType:[control selectedSegmentIndex]];
    if ([control selectedSegmentIndex]==kImageShape)
        _colorControl.hidden=YES;
    else
        _colorControl.hidden=NO;
    
}
@end
