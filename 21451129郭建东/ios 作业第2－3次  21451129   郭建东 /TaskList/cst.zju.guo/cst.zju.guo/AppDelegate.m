//
//  AppDelegate.m
//  cst.zju.guo
//
//  Created by cstlab on 14/11/6.
//  Copyright (c) 2014年 cstlab. All rights reserved.
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
        tasks = [[NSMutableArray alloc]init];
    }
    
    CGRect windowFrame = [[UIScreen mainScreen]bounds];
    UIWindow *thewindow = [[UIWindow alloc]initWithFrame:windowFrame];
    [self setWindow:thewindow];
    CGRect tableFrame  = CGRectMake(0, 80, 320, 380);
    CGRect FieldFrame =CGRectMake(20, 40,200,31);
    CGRect buttonFrame  =CGRectMake(228, 40, 72, 31);
    CGRect delbutton = CGRectMake(300, 40, 72, 31);
    
    taskTable = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    taskField = [[UITextField alloc]initWithFrame:FieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@" Type a task ,tap Insert"];
    
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    [insertButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deleteButton setFrame:delbutton];
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteTask:) forControlEvents:UIControlEventTouchUpInside];
    [[self window]addSubview:taskTable];
    [[self window]addSubview:taskField];
    [[self window]addSubview:insertButton];
    [[self window] addSubview:deleteButton];
    
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    [taskTable setDataSource:self];
    if ([tasks count] ==0) {
        [tasks addObject:@"Walk the dogs"];
        [tasks addObject:@"Feed the hogs"];
        [tasks addObject:@"Chop the logs"];
    }
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   // save the  data when the task is over
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
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
if(editingStyle == UITableViewCellEditingStyleDelete)
{
    [tasks removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    /*
    NSInteger from = [sourceIndexPath row];
    NSInteger to = [destinationIndexPath row];
    //[tasks:from];
   // id object = [tasks removeObjectAtIndex:from];
    id object = [tasks objectAtIndex:from];
    [tasks removeObjectAtIndex:sourceIndexPath.row];
    [tasks insertObject:object atIndex:destinationIndexPath.row];
    */
    
    NSString *stringMove = [tasks objectAtIndex:sourceIndexPath.row];
    [tasks removeObjectAtIndex:sourceIndexPath.row];
    [tasks insertObject:stringMove atIndex:destinationIndexPath.row];

    
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    NSString *item = [tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;
}

-(void)deleteTask:(id)sender
{
    [tasks removeObjectAtIndex:0];
    [taskTable reloadData];
}
-(void) addTask:(id)sender
{
    NSString *text = [taskField text];
    if ([text isEqualToString:@""]) {
        return;
    }
    [tasks addObject:text];
    [taskTable reloadData];
    [taskField setText:@""];
    [taskField resignFirstResponder];
}

NSString* docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@""];
}





@end
