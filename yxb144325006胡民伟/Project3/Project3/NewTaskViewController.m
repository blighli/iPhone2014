//
//  AppDelegate.h
//  Project3
//
//  Created by Cocoa on 14/11/9.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "NewTaskViewController.h"
#import "ViewController.h"

@interface NewTaskViewController ()

@end

@implementation NewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//保存新待办事项
- (IBAction)saveTask:(id)sender {
    ViewController *mainItemView=(ViewController *)self.delegate;
    if([self.task.text length]==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"错误" message:@"待办事项不能为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [mainItemView.tasks addObject:self.task.text];
    [self.delegate writeDataToFile];//写入数据
    [self close:sender];
}


//关闭按钮
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
