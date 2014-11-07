//
//  NewTaskViewController.m
//  task
//
//  Created by 黄盼青 on 14/11/6.
//  Copyright (c) 2014年 docee. All rights reserved.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//保存新待办事项
- (IBAction)saveTask:(id)sender {
    ViewController *mainItemView=(ViewController *)self.delegate;
    
    
    if([self.task.text length]==0)
    {
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
