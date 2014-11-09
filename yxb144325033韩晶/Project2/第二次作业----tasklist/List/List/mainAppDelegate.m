//
//  mainAppDelegate.m
//  List
//
//  Created by hanxue on 14-11-7.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import "mainAppDelegate.h"
@interface mainAppDelegate ()

@end
@implementation mainAppDelegate


NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    }
    else {
        tasks = [[NSMutableArray alloc] init];
    }
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *theWindow = [[UIWindow alloc] initWithFrame: windowFrame];
    [self setWindow: theWindow];
    
    CGRect tableFrame = CGRectMake(0, 80, 320, 380);//横坐标、纵坐标、宽、高
    CGRect fieldFrame = CGRectMake(50, 40, 185, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    CGRect editFrame=CGRectMake(0, 40, 60, 31);
    
    taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    
    taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task, tap Insert"];
    
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    
    [insertButton addTarget:self action:@selector(addTask:)forControlEvents:UIControlEventTouchUpInside];
    
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
    if ([tasks count] == 0) {
        [tasks addObject:@"aaaa"];
        [tasks addObject:@"bbbb"];
        [tasks addObject:@"cccc"];
    }
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
@end














