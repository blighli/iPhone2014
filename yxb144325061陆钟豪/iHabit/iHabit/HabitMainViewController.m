//
//  HabitMainViewController.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/17.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "HabitMainViewController.h"

@interface HabitMainViewController ()

@end


@implementation HabitMainViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    HabitTableViewController *habitTableViewController = [[HabitTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 100)];
    navigationBarView.backgroundColor = UIColor.whiteColor;
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 100)];
    titleLable.font = [UIFont fontWithName:@"Raleway-MediumTracked" size:40];
    titleLable.text = @"iHabit";
    
    // 添加nav阴影
    navigationBarView.layer.shadowColor = [UIColor blackColor].CGColor;
    navigationBarView.layer.shadowOffset = CGSizeMake(0, 0);
    navigationBarView.layer.shadowOpacity = 0.5;
    navigationBarView.layer.shadowRadius = 5;
    
    habitTableViewController.view.frame = CGRectMake(0, 80 - 20, 320, 568 - (80 - 20));

    [self addChildViewController:habitTableViewController];
    
    [navigationBarView addSubview:titleLable];
    [self.view addSubview:habitTableViewController.view];
    [self.view addSubview:navigationBarView];
    
    _habitTableViewController = habitTableViewController;
    
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
