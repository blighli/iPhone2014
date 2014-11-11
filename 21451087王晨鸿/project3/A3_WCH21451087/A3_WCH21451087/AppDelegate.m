//
//  AppDelegate.m
//  A3_WCH21451087
//
//  Created by qtsh on 14-11-8.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailsViewController.h"
NSString *docPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //初始化
    deleteState=0;
    changeState=0;
    currentSearchPosition = -1;
    preText=[[NSMutableString alloc] init];
    [preText appendString:@""];
    
    //设置文件路径
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
        if (plist) {
            tasks = [plist mutableCopy];
        } else {
            tasks = [[NSMutableArray alloc] init];
        }
    
    //画主窗口
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *theWindow = [[UIWindow alloc] initWithFrame: windowFrame]; [self setWindow: theWindow];
    
    //设置控件的范围
    CGRect tableFrame = CGRectMake(0, 115, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 300, 31);
    CGRect buttonInsertFrame = CGRectMake(20, 80, 72, 31);
    CGRect buttonDeleteFrame = CGRectMake(95, 80, 72, 31);
    CGRect buttonChangeFrame = CGRectMake(170, 80, 72, 31);
    CGRect buttonQueryFrame = CGRectMake(245, 80, 72, 31);
    //添加控件
    taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    //[taskTable setEditing:no animated:YES];
    
    
    taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"输入，并点击insert,change或者query"];
    
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonInsertFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    
    deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deleteButton setFrame:buttonDeleteFrame];
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    
    changeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [changeButton setFrame:buttonChangeFrame];
    [changeButton setTitle:@"Change" forState:UIControlStateNormal];
    
    queryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [queryButton setFrame:buttonQueryFrame];
    [queryButton setTitle:@"Query" forState:UIControlStateNormal];
    
    //为按钮设置回调
    [insertButton addTarget:self action:@selector(addTask:)//insert
           forControlEvents:UIControlEventTouchUpInside];
    [taskTable setUserInteractionEnabled:YES];
    [deleteButton addTarget:self action:@selector(deleteTask:)//delete
           forControlEvents:UIControlEventTouchUpInside];
    [taskTable setUserInteractionEnabled:YES];
    [changeButton addTarget:self action:@selector(changeTask:)//change
           forControlEvents:UIControlEventTouchUpInside];
    [taskTable setUserInteractionEnabled:YES];
    [queryButton addTarget:self action:@selector(queryTask:)//query
           forControlEvents:UIControlEventTouchUpInside];
    [taskTable setUserInteractionEnabled:YES];
    
    
    //将三个UI对象加入UIWindow中
    [[self window] addSubview:taskTable];
    [[self window] addSubview:taskField];
    [[self window] addSubview:insertButton];
    [[self window] addSubview:deleteButton];
    [[self window] addSubview:changeButton];
    [[self window] addSubview:queryButton];
    
    
    //设置UIWindow的背景颜色,并放到屏幕上
    [[self window] setBackgroundColor: [UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    
    //将Application Delegate设置为UITableView的数据源
    [taskTable setDataSource:self];
    [taskTable setDelegate:self];
    
    
    //为数据源预先填入数据
    if ([tasks count] == 0) {
        [tasks addObject:@"Walk the dogs"];
        [tasks addObject:@"Feed the hogs"];
        [tasks addObject:@"Chop the logs"];
    }
    
    

        return YES;
}

//设置删除样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

//还是UITableViewCellEditingStyleDelete执行删除或者插入
- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tasks removeObjectAtIndex:row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"can edit");
    return YES;
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"here");
    return YES;
}

//选中行时的操作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"here");
//    //[self tableView:tableView canEditRowAtIndexPath:indexPath];
//    UITableViewCell *oneCell = [tableView cellForRowAtIndexPath: indexPath];
//    if (oneCell.accessoryType != UITableViewCellAccessoryCheckmark) {
//        NSLog(@"into");
//        oneCell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else
//    {
//        oneCell.accessoryType = UITableViewCellAccessoryNone;
//        NSLog(@"into2");
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];}
}

//作为数据源必须实现的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"]
;
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}


//处理按钮的事件
- (void)addTask:(id)sender {
    @try {
    [taskTable setEditing:NO animated:NO];
    deleteState = 0;
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    
    NSString *text = [taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""]) {
    return; //如果是空的什么也不做
    }
    [tasks addObject: text];//将新的任务添加到模型
    [taskTable reloadData]; //表格视图重新载入数据
    [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
    }
    @catch (NSException *exception) {
    }
}
- (void)deleteTask:(id)sender {
    @try {
    
    //设置是否可以删除行
    if (deleteState == 0) {
        [taskTable setEditing:YES animated:YES];
        deleteState = 1;
        [deleteButton setTitle:@"Cancel" forState:UIControlStateNormal];
    }
    else
    {
        [taskTable setEditing:NO animated:NO];
        deleteState = 0;
        [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    }
//    NSIndexPath *indexPath = [taskTable indexPathForSelectedRow];
//    //UITableViewCell *cell = [taskTable cellForRowAtIndexPath:indexPath];
//    [tasks removeObjectAtIndex:[indexPath row]];//删除文本
    [taskTable reloadData]; //表格视图重新载入数据
    [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
    }
    @catch (NSException *exception) {
        
    }

}
- (void)changeTask:(id)sender {
    @try {
        
    
    [taskTable setEditing:NO animated:NO];
    deleteState = 0;
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    
    NSString *text = [taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""]) {
        return; //如果是空的什么也不做
    }
    NSIndexPath *indexPath = [taskTable indexPathForSelectedRow];
    UITableViewCell *cell = [taskTable cellForRowAtIndexPath:indexPath];
    [tasks replaceObjectAtIndex:[indexPath row] withObject:text];//替换文本
    [taskTable reloadData]; //表格视图重新载入数据
    [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
    }
    @catch (NSException *exception) {
    }

}
- (void)queryTask:(id)sender {
    @try {

    [taskTable setEditing:NO animated:NO];
    deleteState = 0;
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    [taskField resignFirstResponder];
        for( int j =0; j<[tasks count]; j++)
        {
                UITableViewCell* temp= [taskTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
                temp.selected =NO;
        }
    NSString *text = [taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""]) {
        preText=[[NSMutableString alloc] init];
        [preText appendString:@""];
        return; //如果是空的什么也不做
    }
    int i=0;
    //判断文字是否改变
//    if ([preText isEqualToString:text]) {
//        i=currentSearchPosition+1;
//        if (currentSearchPosition == [tasks count]-1) {
//            i=0;
//        }
//    }
//    else
//    {
//        i=0;
//        //更新pretext
//        preText=[[NSMutableString alloc] init];
//        [preText appendString:text];
//    }
    //找后面的元素
    for (; i<[tasks count]; i++) {
        if([(NSString*)(tasks[i]) containsString:text]==YES)
        {
//            if (currentSearchPosition!=-1) {
//                UITableViewCell* temp2= [taskTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSearchPosition inSection:0]];
//                temp2.selected =NO;
//            }
//            currentSearchPosition=i;
//            [taskTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i  inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//            UITableViewCell* temp= [taskTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//            temp.selected =YES;
//        break;
                        UITableViewCell* temp= [taskTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                        temp.selected =YES;
        }
    }
    //如果后面没找到,再从头开始找第一个包含的
//    int j;
//    if (i==[tasks count]) {
//        for ( j=0; j<[tasks count]; j++) {
//            if([tasks[j] containsObject:text])
//            {
//                if (currentSearchPosition!=-1) {
//                    UITableViewCell* temp2= [taskTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentSearchPosition inSection:0]];
//                    temp2.selected =NO;
//                }
//                currentSearchPosition=j;
//                [taskTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i  inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//                UITableViewCell* temp= [taskTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0]];
//                temp.selected =YES;
//                
//                
//                break;
//            }
//
//        }
//    }
//    //如果再没找到，说明就是没有
//    if(j == [tasks count])
//        currentSearchPosition=-1;
    }
    @catch (NSException *exception) {
        
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //[textField resignFirstResponder];
    NSLog(@"return");
    [taskField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [taskField resignFirstResponder];
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
}

@end
