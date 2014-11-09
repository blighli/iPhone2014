//
//  AppDelegate.h
//  Project3
//
//  Created by Cocoa on 14/11/9.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
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
    if([self.editingTask.text isEqualToString:[self.delegate tasks][self.taskIndex.row]]){
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
