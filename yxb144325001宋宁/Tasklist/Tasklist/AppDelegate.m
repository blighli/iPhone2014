//
//  AppDelegate.m
//  Tasklist
//
//  Created by NimbleSong on 14/11/6.
//  Copyright (c) 2014年 宋宁. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


NSString *docPath(){
    NSArray *pathList=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.tex"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray *plist=[NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks=[plist mutableCopy];
    }else{
        tasks=[[NSMutableArray alloc]init];
    }
    
    
    NSLog(@"%lu",(unsigned long)[tasks count]);
    
    if ([tasks count]==0) {
        [tasks addObject:@"Walk"];
        [tasks addObject:@"run"];
        [tasks addObject:@"back"];
    }
    //[tasks writeToFile:docPath() atomically:YES];
    
    
    CGRect windowFrame=[[UIScreen mainScreen]bounds];
    UIWindow *theWindow=[[UIWindow alloc] initWithFrame:windowFrame];
    [self setWindow:theWindow];
    
    CGRect tableFrame=CGRectMake(0, 80, 320, 380);
    CGRect fieldFrame=CGRectMake(60,40,200,31);
    CGRect buttomFrame=CGRectMake(260, 40, 60,31);
    CGRect editFrame=CGRectMake(0, 40, 60, 31);
    
    taskTable=[[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    taskTable.allowsSelectionDuringEditing=YES;
    
    
    taskField=[[UITextField alloc]initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task,tap insert"];
    
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttomFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    [insertButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    
    editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editButton setFrame:editFrame];
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editTask:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self window]addSubview:taskTable];
    [[self window]addSubview:taskField];
    [[self window]addSubview:insertButton];
    [[self window]addSubview:editButton];
    
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    [taskTable setDataSource:self];
    
    flag=YES;
    isEdit=NO;
    
    return YES;
}

-(void) editTask:(id)sender{
    if (flag==YES) {
        [taskTable setEditing:YES animated:YES];
        [editButton setTitle:@"Undo" forState:UIControlStateNormal];
        flag=NO;
    }else{
        [taskTable setEditing:NO animated:NO];
        [editButton setTitle:@"Edit" forState:UIControlStateNormal];
        flag=YES;
    }
    
}

-(void) addTask:(id)sender{
        NSString *text=[taskField text];
        if ([text isEqualToString:@""]) {
            return;
        }
        [tasks addObject:text];
        [taskTable reloadData];
        [taskField setText:@""];
        [taskField resignFirstResponder];
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tasks count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    
    NSString *item=[tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return  cell;
}

//实现滑动删除数据;
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tasks removeObjectAtIndex:[indexPath row]];
        [taskTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tasks writeToFile:docPath() atomically:YES];
        selected=(NSInteger *) NSNotFound;
    }
}

//实现tableView调整


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}
//这个方法用来告诉表格 这一行是否可以移动
-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//执行移动操作
-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSUInteger fromRow=[sourceIndexPath row];
    NSUInteger toRow=[destinationIndexPath row];
    
    id object=[tasks objectAtIndex:fromRow];
    [tasks removeObjectAtIndex:fromRow];
    [tasks insertObject:object atIndex:toRow];
    [tasks writeToFile:docPath() atomically:YES];
}

//点击后的操作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected!!");
    taskField.text=[tasks objectAtIndex:indexPath.row];
    *(selected)=indexPath.row;
    isEdit=YES;
    [insertButton setTitle:@"Edit" forState:UIControlStateNormal];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

@end
