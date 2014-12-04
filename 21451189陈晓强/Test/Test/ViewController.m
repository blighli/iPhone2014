//
//  ViewController.m
//  Test
//
//  Created by 陈晓强 on 14/11/29.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "ViewController.h"
#import "SmoothLineView.h"
@interface ViewController ()
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [self.view addSubview:[[SmoothLineView alloc] initWithFrame:self.view.bounds]];
}


@end
