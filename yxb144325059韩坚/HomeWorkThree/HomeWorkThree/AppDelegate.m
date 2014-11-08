//
//  AppDelegate.m
//  HomeWorkThree
//
//  Created by HJ on 14/11/5.
//  Copyright (c) 2014年 HJ. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    int row;
}

@end

@implementation AppDelegate

NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

//按钮处理事件
- (void)addTask:(id)sender
{
    NSString *text = [taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""])
    {
        return; //如果是空的什么也不做
    }
    [tasks addObject: text]; //将新的任务添加到模型
    [taskTable reloadData]; //表格视图重新载入数据
    [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
}
//UITableViewDataSource必须实现两个方法:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}
//UITableViewDataSource必须实现两个方法:
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]]; [[cell textLabel] setText:item];
    return cell ;
}
//按下table
- (BOOL)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    taskField.text = [tasks objectAtIndex: indexPath.row];
    [taskField becomeFirstResponder];
    row = (int)indexPath.row;
    
    return YES;
}
//按下return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (row != -1)
    {
        NSString *text = [taskField text]; //从输入框获取新的任务
        if ([text isEqualToString:@""])
        {
            return YES; //如果是空的什么也不做
        }
        [tasks replaceObjectAtIndex:row withObject: text]; //将新的任务添加到模型
        [taskTable reloadData]; //表格视图重新载入数据
    }
    [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
    return YES;
}

//进入删除模式，按下出现的删除按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    row = -1;
    [tasks removeObjectAtIndex: indexPath.row];
    [taskTable reloadData];
    [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    } else {
        tasks = [[NSMutableArray alloc] init];
        [tasks addObject:@"修改：点cell，输入，点return"];
        [tasks addObject:@"删除：向左滑动cell，点删除"];
        [tasks addObject:@"增加：输入，点insert"];
        [tasks addObject:@"支持退出时保存到文件"];
    }
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *theWindow = [[UIWindow alloc] initWithFrame: windowFrame];
    [self setWindow: theWindow];
    CGRect tableFrame = CGRectMake(0, 80, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    
    taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [taskTable setDataSource:self];
    [taskTable setDelegate:self];
    taskTable.allowsSelection = YES;
    
    taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task, tap Insert"];
    taskField.delegate = self;
    
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    [insertButton addTarget:self action:@selector(addTask:)forControlEvents:UIControlEventTouchUpInside];
    
    [[self window] addSubview:taskTable];
    [[self window] addSubview:taskField];
    [[self window] addSubview:insertButton];
    [[self window] setBackgroundColor:
    [UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //写入数据：**********
    //将缓冲的数据写入到文件中
    [tasks writeToFile:docPath() atomically:YES];
}

@end
