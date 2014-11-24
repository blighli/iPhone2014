//
//  CellDetailViewController.m
//  MyNotes
//
//  Created by cstlab on 14/11/21.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "CellDetailViewController.h"

@interface CellDetailViewController ()

@end

@implementation CellDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titel.text = self.data.title;
    self.contentview.text = self.data.messsages;
    // Do any additional setup after loading the view from its nib.
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
