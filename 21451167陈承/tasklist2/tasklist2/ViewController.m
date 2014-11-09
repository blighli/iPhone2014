//
//  ViewController.m
//  tasklist2
//
//  Created by Chencheng on 14/11/8.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


NSIndexPath * tmp;
@implementation ViewController


NSMutableArray *tasks;
 

NSString *docPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}
- (void)viewDidLoad//视图的载入函数，预先在视图里添加3个list
{
    [super viewDidLoad];
 NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
  
    if (plist) {
       tasks = [plist mutableCopy];
   } else {
       tasks = [[NSMutableArray alloc] init];
   }
    tasks = [[NSMutableArray alloc] init];
    [self.taskTable setDataSource:self];
    [self.taskTable setDelegate:self];
    if ([tasks count] == 0) {
        [tasks addObject:@"Walk the dogs"];
        [tasks addObject:@"Feed the hogs"];
        [tasks addObject:@"Chop the logs"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{//列表中数据项的个数
    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell )
    {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {//列表每一项的删除
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tasks removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{//单击列表中的每一项，弹出对话框
    //self.taskField.text=[tasks objectAtIndex:indexPath.row];
    tmp =indexPath;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"修改" message:@"您确定要修改吗"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{//点击对话框的确定按钮，将里面文本框的内容替换列表中的单击的那一项
    if(buttonIndex==1)
    {
        
        UITextField *tf=[alertView textFieldAtIndex:0];//定位到文本框
        NSString *editText=[tf text];//获取文本框的内容
        tasks[tmp.row] = editText;//将当前行的内容替换成文本框的内容
        [self.taskTable reloadData];
        [self.taskField setText:@""];
        [self.taskField resignFirstResponder];
    }
}

- (IBAction)insertButton:(id)sender {
    NSString *text = [self.taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""]) {
        return; //如果是空的什么也不做
    }
    [tasks addObject: text]; //将新的任务添加到模型
    [self.taskTable reloadData]; //表格视图重新载入数据
    [self.taskField setText:@""]; //清空输入框
    [self.taskField resignFirstResponder]; //关闭软键盘
}
@end
