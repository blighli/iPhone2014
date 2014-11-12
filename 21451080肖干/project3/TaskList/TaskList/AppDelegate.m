//
//  AppDelegate.m
//  TaskList
//
//  Created by xiaoo_gan on 11/9/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}
- (void)addTask:(id)sender {
    NSString *text = [taskField text];
    if ([text isEqualToString:@""]) {
        return;
    }
    [tasks addObject: text];
    [taskTable reloadData];
    [taskField setText:@""];
    [taskField resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:244/255.0 green:200/255.0 blue:255/255.0 alpha:1];
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"delete";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [tasks removeObjectAtIndex: indexPath.row];
        [taskTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [taskField setText:@""];
        [taskField resignFirstResponder];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"modify" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"comfirm", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].text=tasks[indexPath.row];
    alert.tag=indexPath.row;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) return;
    tasks[alertView.tag]=[alertView textFieldAtIndex:0].text;
    [taskTable reloadData];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    }
    else {
        tasks = [[NSMutableArray alloc] init];
    }
    if ([tasks count] == 0) {
        [tasks addObject:@"hello, world!"];
        [tasks addObject:@"hello, objective-c!!"];
        [tasks addObject:@"hello, iOS!!!"];
    }
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *theWindow = [[UIWindow alloc] initWithFrame: windowFrame];
    [self setWindow: theWindow];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect tableFrame = CGRectMake(20, 80, screenBounds.size.width-20, screenBounds.size.height-200);
    CGRect fieldFrame = CGRectMake(20, 40, screenBounds.size.width-110, 31);
    CGRect buttonFrame = CGRectMake(screenBounds.size.width-80, 40, 72, 31);
    
    taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle: UITableViewCellSeparatorStyleNone];

    [taskTable setDataSource:self];
    [taskTable setDelegate:(id)self];
    taskTable.allowsSelection = YES;
    
    taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task, tap Insert"];
    //[taskField becomeFirstResponder];
    
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    [insertButton setBackgroundColor:[UIColor orangeColor]];
    [insertButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self window] addSubview:taskTable];
    [[self window] addSubview:taskField];
    [[self window] addSubview:insertButton];
    
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    return YES;
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
