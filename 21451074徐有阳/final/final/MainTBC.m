//
//  MainTBC.m
//  final
//
//  Created by xuyouyang on 14/12/17.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "MainTBC.h"

@interface MainTBC ()

@end

@implementation MainTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    self.navigationItem.title = @"新闻";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    switch (tabIndex) {
        case 0:
            self.navigationItem.title = @"新闻";
            break;
        case 1:
            self.navigationItem.title = @"招生";
            break;
        case 2:
            self.navigationItem.title = @"招聘";
            break;
        case 3:
            self.navigationItem.title = @"教务";
            break;
        case 4:
            self.navigationItem.title = @"其他";
            break;
        default:
            break;
    }
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
