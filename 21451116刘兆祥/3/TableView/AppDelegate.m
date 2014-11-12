//
//  AppDelegate.m
//  TableView
//
//  Created by Steve on 14-11-10.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
NSString *docPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    } else {
        tasks = [[NSMutableArray alloc] init];
    }
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *theWindow = [[UIWindow alloc] initWithFrame: windowFrame]; [self setWindow: theWindow];
    CGRect tableFrame = CGRectMake(0, 80, 320, 380); CGRect fieldFrame = CGRectMake(20, 40, 200, 31); CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    //self.tableView = taskTable;
    taskTable.delegate = self;
    myAlertView.delegate=self;
    [taskTable setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    taskField = [[UITextField alloc] initWithFrame:fieldFrame]; [taskField setBorderStyle:UITextBorderStyleRoundedRect]; [taskField setPlaceholder:@"Type a task, tap Insert"];
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; [insertButton setFrame:buttonFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    [insertButton addTarget:self action:@selector(addTask:)
           forControlEvents:UIControlEventTouchUpInside];
    [[self window] addSubview:taskTable]; [[self window] addSubview:taskField]; [[self window] addSubview:insertButton];
    [[self window] setBackgroundColor: [UIColor whiteColor]]; [[self window] makeKeyAndVisible];
    [taskTable setDataSource:self];
    if ([tasks count] == 0) {
        [tasks addObject:@"Walk the dogs"]; [tasks addObject:@"Feed the hogs"]; [tasks addObject:@"Chop the logs"];
    }
    return YES;
}
- (void)addTask:(id)sender {
    NSString *text = [taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""]) {
    return; //如果是空的什么也不做
    }
    [tasks addObject: text]; //将新的任务添加到模型
        [taskTable reloadData]; //表格视图重新载入数据
        [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return [tasks count];
    }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    index=indexPath.row;
    NSString *taskselect=[tasks objectAtIndex:indexPath.row];
    myAlertView =[[UIAlertView alloc]initWithTitle:@"请输入要修改后的内容,若要删除则为空" message:taskselect delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok",nil];
    myAlertView.alertViewStyle=UIAlertViewStylePlainTextInput;
     [myAlertView show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"进来了个");
    if(buttonIndex==0){
        //NSLog(@"cancel");
        return;
    }
    //NSLog(@"ok");
    UITextField *tf = [myAlertView textFieldAtIndex:0];
    NSString *text=tf.text;
    //NSLog(@"INPUT:%@", text);
    if([text isEqual:@""]==YES)
        [tasks removeObjectAtIndex:index];
    else
        [tasks replaceObjectAtIndex:index withObject:text];
    
    
    [taskTable reloadData];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [taskTable dequeueReusableCellWithIdentifier:@"Cell"]; if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]]; [[cell textLabel] setText:item];
    return cell ;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
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
