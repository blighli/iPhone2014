//
//  PhotoTableViewController.m
//  MyNotes
//
//  Created by YilinGui on 14-11-22.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "PhotoTableViewController.h"

@interface PhotoTableViewController ()

@end

@implementation PhotoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor blueColor];
    
    // 设置导航栏标题
    self.navigationItem.title = @"Photo Notes";
    
    // 为导航栏添加一个右侧的Button Item
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(AddPhotoNotes)];
    self.navigationItem.rightBarButtonItem = item;
}

// 事件响应函数 -- 添加照片笔记
- (void)AddPhotoNotes {
    
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
