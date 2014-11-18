//
//  PaintViewController.m
//  AnyNote
//
//  Created by 黄盼青 on 14/11/18.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "PaintViewController.h"

@interface PaintViewController ()

@end

@implementation PaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)viewExit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearPaintView:(id)sender {
    [_paintView clearView];
}

- (IBAction)changeLineWidth:(UIStepper *)sender {
    float lineValue=[sender value];
    NSMutableString *newLabel=[NSMutableString stringWithFormat:@"画笔大小:%.0f",lineValue];
    _lineWidthLabel.title=newLabel;
    _paintView.lineWidth=lineValue;
}

- (IBAction)chooseColor:(UIBarButtonItem *)sender {
    UIColor *color=[sender tintColor];
    _paintView.lineColor=color;
}
@end
