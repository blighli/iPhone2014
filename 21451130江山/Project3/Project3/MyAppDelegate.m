//
//  AppDelegate.m
//  Project3
//
//  Created by 江山 on 11/11/14.
//  Copyright (c) 2014 jiangshan. All rights reserved.
//

#import "MyAppDelegate.h"

#import "ViewController.h"

@implementation MyAppDelegate

NSIndexPath * temp;

NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    } else {
        tasks = [[NSMutableArray alloc] init];
    }
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *theWindow = [[UIWindow alloc] initWithFrame: windowFrame];
    [self setWindow: theWindow];
    CGRect tableFrame = CGRectMake(0, 80, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    taskTable = [[UITableView alloc] initWithFrame:tableFrame
                                             style:UITableViewStylePlain];
    [taskTable setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    
    taskField = [[UITextField alloc] initWithFrame:fieldFrame]; [taskField setBorderStyle:UITextBorderStyleRoundedRect]; [taskField setPlaceholder:@"Type a task, tap Insert"]; insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; [insertButton setFrame:buttonFrame]; [insertButton setTitle:@"Insert" forState:UIControlStateNormal]; [insertButton addTarget:self action:@selector(addTask:)forControlEvents:UIControlEventTouchUpInside];
    
    [[self window] addSubview:taskTable]; [[self window] addSubview:taskField]; [[self window] addSubview:insertButton]; [[self window] setBackgroundColor: [UIColor whiteColor]]; [[self window] makeKeyAndVisible];
    
    [taskTable setDataSource:self];
    if ([tasks count] == 0)
    {
        [tasks addObject:@"Walk the dogs"];
        [tasks addObject:@"Feed the hogs"];
        [tasks addObject:@"Chop the logs"];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}

-(void)addTask:(id)sender
{
    NSString *text = [taskField text];//从输入框获取新的任务
    if ([text isEqualToString:@""])
    {
        return; //如果是空的什么也不做
    }
    [tasks addObject: text]; //将新的任务添加到模型
    [taskTable reloadData]; //表格视图重新载入数据
    [taskField setText:@""];//清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tasks removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    temp =indexPath;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"change" message:@"are you sure to change?"delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"yes", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
            
        UITextField *tf=[alertView textFieldAtIndex:0];
        NSString *editText=[tf text];
        tasks[temp.row] = editText;
        [taskTable reloadData];
        [taskField setText:@""];
        [taskField resignFirstResponder];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [tasks writeToFile:docPath() atomically:YES];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
