//
//  AppDelegate.m
//  TaskList
//
//  Created by 樊博超 on 14-11-10.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    }else{
        tasks = [[NSMutableArray alloc] init];
    }
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow * theWindow = [[UIWindow alloc] initWithFrame:windowFrame];
    [self setWindow:theWindow];
    
    CGRect tableFrame = CGRectMake(0, 80, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    
    taskList = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    inputText = [[UITextField alloc] initWithFrame:fieldFrame];
    [inputText setBorderStyle:UITextBorderStyleRoundedRect];
    [inputText setPlaceholder:@"please input a task"];
    
    insert = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insert setFrame:buttonFrame];
    [insert setTitle:@"insert" forState:UIControlStateNormal];
    [insert addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self window] addSubview:taskList];
    [[self window] addSubview:inputText];
    [[self window] addSubview:insert];
    
    
    [[self window] setBackgroundColor: [UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    [taskList setDataSource:self];
    [taskList setDelegate:self];
//    if ([tasks count] == 0) {
//        [tasks addObject:@"Walk the dogs"];
//        [tasks addObject:@"Feed the hogs"];
//        [tasks addObject:@"Chop the logs"];
//    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [tasks writeToFile:docPath() atomically:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [tasks writeToFile:docPath() atomically:YES];
}

NSString * docPath(){
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSLog(@"run a time");
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

-(void)addTask:(id)sender{
    NSString * text = [inputText text];
    if ([text isEqualToString:@""]) {
        return;
    }
    [tasks addObject:text];
    [taskList reloadData];
    [inputText setText:@""];
    [inputText resignFirstResponder];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [taskList dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    row = [indexPath row];
    NSString *rowValue = [tasks objectAtIndex:row];
    NSString *message = [[NSString alloc] initWithFormat:@"你选择了第%ld行。", row];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"编辑界面"
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"cancel"
                                         otherButtonTitles:@"edit",@"delete",nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    textField = [alert textFieldAtIndex:0];
    textField.text = rowValue;
   // [message release];
    [alert show];
    //[alert release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:{
            tasks[row] = textField.text;
            [taskList reloadData];
        }break;
        case 2:{
            [tasks removeObjectAtIndex:row];
            [taskList reloadData];
        }break;
        default:
            break;
    }
}

@end
