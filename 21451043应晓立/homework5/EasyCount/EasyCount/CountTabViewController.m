//
//  CountTabViewController.m
//  EasyCount
//
//  Created by yingxl1992 on 15/1/8.
//  Copyright (c) 2015年 21451043应晓立. All rights reserved.
//

#import "CountTabViewController.h"

@interface CountTabViewController ()

@end

@implementation CountTabViewController

//设置左右侧滑动菜单栏
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
    return NO;
}

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

@end
