//
//  AppDelegate.m
//  MyTaskList
//
//  Created by cstlab on 14-11-10.
//  Copyright (c) 2014年 Tan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property(nonatomic, strong)NSIndexPath *indexSelectedPath;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray* plist = [NSArray arrayWithContentsOfFile:[self docPath]];
    if (plist ) {
        tasks = [plist mutableCopy];
    }else
        tasks = [[NSMutableArray alloc] init];
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *theWindow = [[UIWindow alloc] initWithFrame:windowFrame];
    [self setWindow:theWindow];
    
    CGRect tableFrame = CGRectMake(0, 80, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect btnFrame = CGRectMake(228, 40, 72, 31);
    
    taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task, tap Insert"];
    
    insertBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertBtn setFrame:btnFrame];
    [insertBtn setTitle:@"Insert" forState:UIControlStateNormal];
    
    [insertBtn addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self window] addSubview:taskTable];
    [[self window] addSubview:taskField];
    [[self window] addSubview:insertBtn];
    
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    [taskTable setDataSource:self];
    taskTable.delegate=self;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [tasks writeToFile:[self docPath] atomically:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [tasks writeToFile:[self docPath] atomically:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSString*) docPath{
    NSArray * pathList = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory , NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingString:@"data.txt"];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tasks count] == 0) {
        [tasks addObject:@"Walk the dogs"];
        [tasks addObject:@"Feed the hogs"];
        [tasks addObject:@"Chop the logs"];
    }
    
    return [tasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString* item = [tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tasks removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}

-(void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [taskField resignFirstResponder];
    _indexSelectedPath = indexPath;
    id temp = [tasks objectAtIndex:[indexPath row]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"任务修改" message: temp delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改",nil];
    
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *ft = [alertView textFieldAtIndex:0];
    NSString* changedContent = [ft text];
    [tasks replaceObjectAtIndex:[_indexSelectedPath row] withObject:changedContent];
    [taskTable reloadData];
}

-(void)alertViewCancel:(UIAlertView *)alertView{

}

-(void)addTask:(id)sender{
    NSString * text = [taskField text];
    if ([text isEqualToString:@""]) {
        return;
    }
    [tasks addObject:text];
    [taskTable reloadData];
    [taskField setText:@""];
    [taskField resignFirstResponder];
}

@end
