//
//  SettingTableViewController.m
//  project4
//
//  Created by zack on 14-11-23.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import "SettingTableViewController.h"
#import "AppDelegate.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (IBAction)setSize:(id)sender {
    ((AppDelegate *)[[UIApplication sharedApplication] delegate]).size = [[NSDecimalNumber alloc] initWithFloat:_silder.value];
}

- (IBAction)exit:(id)sender {
}
@end
