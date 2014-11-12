//
//  ViewController.m
//  tasklist
//
//  Created by liug on 14-11-8.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "ViewController.h"
NSIndexPath * indexpath;
@interface ViewController ()

@end

@implementation ViewController
@synthesize textfield,tasktable;
- (IBAction)insert:(id)sender {
    NSString *text = [textfield text]; //从输入框获取新的任务
    if ([text isEqualToString:@""]) {
        return; //如果是空的什么也不做
    }
    else{
        [tasklist addObject: text]; //将新的任务添加到模型
        [tasktable reloadData]; //表格视图重新载入数据
        textfield.text=@""; //清空输入框
        [textfield resignFirstResponder]; //关闭软键盘
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasklist = [plist mutableCopy];
    } else {
        tasklist = [[NSMutableArray alloc] init];
    }
    [tasktable setDataSource:self];
    [tasktable setDelegate:self];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [tasklist writeToFile:docPath() atomically:YES];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasklist count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tasktable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasklist objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}
//section显示的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Task List";
}
/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tasklist removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        [tasktable deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}

//设置可编辑的行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexpath=indexPath;
    UIAlertView *aler=[[UIAlertView alloc]initWithTitle:@"编辑任务" message:@"" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"编辑", nil];
    aler.alertViewStyle=UIAlertViewStylePlainTextInput;
    [aler show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        UITextField *temp=[alertView textFieldAtIndex:0];
        tasklist[indexpath.row]=temp.text;
        [tasktable reloadData];
    }
}
NSString *docPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

@end
