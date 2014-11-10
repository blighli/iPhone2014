//
//  AppDelegate.m
//  TaskList
//
//  Created by 杨长湖 on 14/11/9.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
//一般将文件保存到沙盒的Document目录下
NSString *docPath(){
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //数据初初始化
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    }
    else {
        tasks = [[NSMutableArray alloc] init];
    }
    
    //创建应用程序的主窗口（UIWindow）
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *theWindow = [[UIWindow alloc] initWithFrame: windowFrame];
    [self setWindow: theWindow];
    
    //设置三个UI对象的frame属性
    CGRect tableFrame = CGRectMake(0, 80, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    
    //创建并设置表格UITableView
    taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    
    //创建并设置文本框（UITextField ）
    taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task, tap Insert"];
    
    //创建并设置按钮（UIButton ）
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    
    //为按钮设置回调
    [insertButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    
    //将三个UI对象加入UIWindow中
    [[self window] addSubview:taskTable];
    [[self window] addSubview:taskField];
    [[self window] addSubview:insertButton];
    
    //设置UIWindow的背景颜色，并放到屏幕上
    [[self window] setBackgroundColor: [UIColor whiteColor]];
    [[self window] makeKeyAndVisible];

    //将Application Delegate设置为UITableView的数据源
    [taskTable setDataSource:self];
    [taskTable setDelegate:self];
    return YES;
}
//UITableViewDataSource必须实现两个方法：
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}
//处理按钮的事件
-(void)addTask:(id)sender {
    NSString *text = [taskField text];//从输入框获取新的任务
    if ([text isEqualToString:@""]) {
        return; //如果是空的什么也不做
    }
    [tasks addObject: text]; //将新的任务添加到模型
    //[tasks delete: text];
    [taskTable reloadData]; //表格视图重新载入数据
    [taskField setText:@""];//清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
}

- (void)tableView:(UITableView *)tableView UILongPressGestureRecognizer:(NSIndexPath *)indexPath{
    printf("长按某一行的cel/n");
}

//单击某一行的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    printf("单击某一行的cell/n");
    //tasks[indexPath.row];
    //创建弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息更改" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", @"删除",nil];
    
    // 设置样式（一个明文文本框）
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    // 设置文本框的默认文字
    [alert textFieldAtIndex:0].text = tasks[indexPath.row];
    
    // 2.显示弹框
    [alert show];
    
    // 3.绑定行号 为 alertview的tag
    alert.tag = indexPath.row;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //取出文本框的文字
    NSString *text = [alertView textFieldAtIndex:0].text;
    int row = alertView.tag;
    if (buttonIndex == 0) {
        //printf("取消");
        return;
    }
    if (buttonIndex == 2) {
        //printf("删除");
        [tasks removeObjectAtIndex:row];
        [taskTable reloadData];
        [taskField resignFirstResponder];
        return;
    }
    tasks[row] = text;
    [taskTable reloadData];
    [taskField resignFirstResponder];
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //当应用退出时保存任务数据
    [tasks writeToFile:docPath() atomically:YES];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
