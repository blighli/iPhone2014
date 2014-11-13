//
//  AppDelegate.m
//  Tasklist
//
//  Created by C.C.R on 14/11/6.
//  Copyright (c) 2014年 TOM. All rights reserved.
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
        [tasks addObject:@"Slide Delete"];
        [tasks addObject:@"Click Edit"];
        [tasks addObject:@"Click Adjust"];
    }
    //[tasks writeToFile:docPath() atomically:YES];
    
    
    CGRect windowFrame=[[UIScreen mainScreen]bounds];
    UIWindow *theWindow=[[UIWindow alloc] initWithFrame:windowFrame];
    [self setWindow:theWindow];
    
    CGRect tableFrame=CGRectMake(0, 80, 320, 400);
    CGRect fieldFrame=CGRectMake(60,40,244,31);
    CGRect buttomFrame=CGRectMake(260, 40, 60,31);
    CGRect editFrame=CGRectMake(0, 40, 60, 31);
    
    taskTable=[[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [taskTable setDataSource:self];
    [taskTable setDelegate:(id)self];
    //[taskTable setEditing:NO animated:YES];
    taskTable.allowsSelection=YES;
    taskTable.allowsSelectionDuringEditing=YES;
    
    
    taskField=[[UITextField alloc]initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task,tap insert"];
    [taskField setDelegate:(id) self];
    
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttomFrame];
    [insertButton setTitle:@"" forState:UIControlStateNormal];
    [insertButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    insertButton.hidden=YES;
    
    editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editButton setFrame:editFrame];
    [editButton setTitle:@"Adjust" forState:UIControlStateNormal];
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
    isFocus=NO;
    
    return YES;
}

-(void) editTask:(id)sender{
    if(isFocus){
        [taskField setText:@""];
        CGRect fieldFrame=CGRectMake(60,40,244,31);
        [taskField setFrame:fieldFrame];
        insertButton.hidden=YES;
        [editButton setTitle:@"Adjust" forState:UIControlStateNormal];
        [taskField resignFirstResponder];
        isFocus=NO;
        selected=nil;
        return;
    }
        if (flag==YES) {
            [taskTable setEditing:YES animated:YES];
            [editButton setTitle:@"Back" forState:UIControlStateNormal];
            flag=NO;
        }else{
            [taskTable setEditing:NO animated:YES];
            [editButton setTitle:@"Adjust" forState:UIControlStateNormal];
            flag=YES;
        }
    
    
}

-(void) addTask:(id)sender{
        NSString *text=[taskField text];
        if ([text isEqualToString:@""]) {
            return;
        }
    [taskTable setEditing:NO animated:YES];
    [editButton setTitle:@"Adjust" forState:UIControlStateNormal];
    flag=YES;
    
    if (isEdit&&selected) {
        [tasks replaceObjectAtIndex:selected.row withObject:text];
        isEdit=NO;
        [insertButton setTitle:@"insert" forState:UIControlStateNormal];
        selected=nil;
    }else{
        [tasks addObject:text];
    }
        [taskTable reloadData];
        [taskField setText:@""];
        [taskField resignFirstResponder];
    isFocus=NO;
    CGRect fieldFrame=CGRectMake(60,40,244,31);
    [taskField setFrame:fieldFrame];
    insertButton.hidden=YES;
    
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
    cell.selectedBackgroundView=[[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:0.5];
    return  cell;
}

//重新赋背景色
-(void)reloadcellbackground:(NSIndexPath *)indexPath{
    for (NSInteger i = indexPath.row; i<=(NSInteger) [tasks count]; i++) {
        UITableViewCell *cell = [taskTable  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
        if (cell) {
            if (i%2==0) {
                cell.backgroundColor=[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:0.5];
            }else{
                cell.backgroundColor=[UIColor whiteColor];
            }
        }
    }
}

//实现滑动删除数据;
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tasks removeObjectAtIndex:[indexPath row]];
        [taskField setText:@""];
        [taskField resignFirstResponder];
        isFocus=NO;
        [taskTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        //[taskTable reloadData];
        [self reloadcellbackground:indexPath];

        [tasks writeToFile:docPath() atomically:YES];
        selected=nil;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete Me!";
}

//实现tableView调整


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
//这个方法用来告诉表格 这一行是否可以移动
-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//执行移动操作

-(BOOL) tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSUInteger fromRow=[sourceIndexPath row];
    NSUInteger toRow=[destinationIndexPath row];
    
    id object=[tasks objectAtIndex:fromRow];
    [tasks removeObjectAtIndex:fromRow];
    [tasks insertObject:object atIndex:toRow];
    [taskTable reloadData];
    [tasks writeToFile:docPath() atomically:YES];
}

//点击后的操作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected!!%lu!!!!%lu",indexPath.row,indexPath.section);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!isEdit||selected.row!=indexPath.row) {
        [insertButton setTitle:@"Edit" forState:UIControlStateNormal];
        CGRect fieldFrame=CGRectMake(60,40,200,31);
        [taskField setFrame:fieldFrame];
        insertButton.hidden=NO;
        taskField.text=[tasks objectAtIndex:indexPath.row];
        selected=indexPath;
        isEdit=YES;
        isFocus=YES;
        [editButton setTitle:@"Undo" forState:UIControlStateNormal];
        
    }else if(selected.row==indexPath.row){
        [insertButton setTitle:@"insert" forState:UIControlStateNormal];
        CGRect fieldFrame=CGRectMake(60,40,244,31);
        [taskField setFrame:fieldFrame];
        insertButton.hidden=YES;
        taskField.text=@"";
        selected=nil;
        isEdit=NO;
        
    }
}

//textfield焦点控制
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField becomeFirstResponder]&&!isEdit) {
        CGRect fieldFrame=CGRectMake(60,40,200,31);
        [taskField setFrame:fieldFrame];
        [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
        [editButton setTitle:@"Undo" forState:UIControlStateNormal];
        insertButton.hidden=NO;
        isFocus=YES;
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [insertButton setTitle:@"" forState:UIControlStateNormal];
    isFocus=NO;
}

//按下return调用addtask方法
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self addTask:@"\n"];
    }
    return YES;
}

//设置隔行换色
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row]%2==0) {
        cell.backgroundColor=[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:0.5];
    }
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
