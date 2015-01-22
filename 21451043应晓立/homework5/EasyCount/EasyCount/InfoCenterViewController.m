//
//  InfoCenterViewController.m
//  EasyCount
//
//  Created by yingxl1992 on 14/12/20.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "InfoCenterViewController.h"

@interface InfoCenterViewController ()

@end

@implementation InfoCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    userInfo=[NSUserDefaults standardUserDefaults];
    _userLable.text=[userInfo valueForKey:@"username"];
    
    [_logoutBtn addTarget:self action:@selector(logout) forControlEvents:1];
}

- (void)logout {
    [userInfo removeObjectForKey:@"username"];
    [userInfo removeObjectForKey:@"pwd"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
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
