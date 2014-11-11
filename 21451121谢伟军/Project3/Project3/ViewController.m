//
//  ViewController.m
//  Project3
//
//  Created by xvxvxxx on 14/11/9.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self readFile];
    [self.taskField setBorderStyle:UITextBorderStyleRoundedRect];
    
    
    if ([self.tasks count] == 0) {
        [self.tasks addObject:@"Walk the dogs"];
        [self.tasks addObject:@"Feed the hogs"];
        [self.tasks addObject:@"Chop the logs"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTask:(UIButton *)sender {
    NSString *text = [self.taskField text];
    if ([text isEqualToString:@""]) {
        return;
    }
    [self.tasks addObject: text];
    [self.taskTable reloadData];
    [self.taskField setText:@""];
    [self.taskField resignFirstResponder];
    
    [self.tasks writeToFile:[self docPath] atomically:YES];
}




-(NSString *)docPath {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}
-(void)readFile{
    NSArray *plist = [NSArray arrayWithContentsOfFile:[self docPath]];
    if (plist) {
        self.tasks = [plist mutableCopy];
    } else {
        self.tasks = [[NSMutableArray alloc] init];
    }
}

#pragma datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tasks count];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"]; if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [self.tasks objectAtIndex: [indexPath row]]; [[cell textLabel] setText:item];
    return cell ;
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

//删除单元并更新文件
- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUInteger row = [indexPath row];
        
        //删除数组中对应元素
        [self.tasks removeObjectAtIndex:row];
        
        //将删除后的写入文件
        [self.tasks writeToFile:[self docPath] atomically:YES];
        
        //删除tableView中对应数据的单元
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tasks writeToFile:[self docPath] atomically:YES];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *task = self.tasks[indexPath.row];
    NSString *title = @"修改任务？";
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:[NSString stringWithFormat:@"当前任务:%@",task] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    // alertViewStyle 样式----密码
    // alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    // alertViewStyle 样式----一般的文本输入框
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    // alertViewStyle 样式----用户名及密码登录框
    // alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    // alertViewStyle 样式----标签显示
    // alert.alertViewStyle = UIAlertViewStyleDefault;
    
    // 用户名密码的情况下有两个文本框
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.text = task;
    // 关键代码,通过tag将点击的行号带给alertView的代理方法,还可以通过利用代理即控制器的成员进行 行号 的传递~
    textField.tag = indexPath.row;
    // 显示alertView
    [alert show];
    
    
    
}


#pragma mark - UIAlertViewDelegate的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 查看点击了alertView里面的哪一个按钮,取消按钮是 0
    NSLog(@"alertView里面的按钮index---%d",buttonIndex);
    if (buttonIndex == 0) {
        // 0代表取消按钮
        return;
    }else if (buttonIndex == 1){
        // 1代表确定按钮,更新数据源,重新加载数据
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString *newTask = [textField text];
        // robust判断
        if ([newTask isEqualToString:@""]) {
            return;
        }
        // 先更新数据源
        int row = textField.tag;

        self.tasks[row] = newTask;
        // 再,全部重新加载数据
        // [_tableView reloadData];
        
        // 最好是,局部刷新数据,通过row生成一个一个indexPath组成数组
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        NSArray *indexPaths = @[indexPath];
        [self.taskTable reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
        [self.tasks writeToFile:[self docPath] atomically:YES];
    }
}

@end
