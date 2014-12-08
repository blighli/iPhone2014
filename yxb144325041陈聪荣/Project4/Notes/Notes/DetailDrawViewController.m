//
//  DetailDrawViewController.m
//  Notes
//
//  Created by 陈聪荣 on 14/12/6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "DetailDrawViewController.h"

@interface DetailDrawViewController ()

@end

@implementation DetailDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化note类型
    if(_detailItem){
        [_drawView readFromFile:[(Note*)_detailItem content]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)returnOnclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)modifyClick:(id)sender {
    [_drawView writeToFile:[_detailItem content]];
    [_drawView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
