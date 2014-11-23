//
//  ViewController.m
//  Project4
//
//  Created by xvxvxxx on 14/11/20.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myDatabase = [[databaseOperation alloc] init];
    [self.myDatabase openDatabse];
    [self.myDatabase creatTable];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
