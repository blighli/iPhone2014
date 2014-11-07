//
//  TaskViewController.m
//  task
//
//  Created by 黄盼青 on 14/11/6.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "TaskViewController.h"
#import "ViewController.h"

@interface TaskViewController ()

@end

@implementation TaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.editingTask setText:[self.delegate tasks][self.taskIndex.row]];
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

//关闭按钮
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)deleteTask:(id)sender {
    [[self.delegate tasks]removeObjectAtIndex:self.taskIndex.row];
    [self.delegate writeDataToFile];//保存修改数据到文件
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)saveTask:(id)sender {
    
    //如果未做任何修改，则禁止保存
    if([self.editingTask.text isEqualToString:[self.delegate tasks][self.taskIndex.row]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你没有做任何修改!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    //保存修改内容
    [self.delegate tasks][self.taskIndex.row]=self.editingTask.text;
    [self.delegate writeDataToFile];//保存修改数据到文件
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
