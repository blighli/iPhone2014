//
//  TODOListController.m
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import "TODOListController.h"

#import "TaskStore.h"
#import "Task.h"

@interface TODOListController ()

@end

@implementation TODOListController


- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        self.navigationItem.title = @"Simple Task";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                                                                               target:self                                                                                               action:@selector(addTask:)];
    }
    
    return self;
}

// 添加任务
- (void)addTask:(id)sender
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"新的任务"
                                               message:@"输入一个新的TODO项"
                                              delegate:self
                                     cancelButtonTitle:@"取消"
                                     otherButtonTitles:@"完成", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av show];
    
    self.isAdd = YES;
}

// 点击确定添加任务
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *taskString = [alertView textFieldAtIndex:0].text;
        if (![taskString isEqualToString:@""]) {
            
            if (self.isAdd) {
                Task *task = [[TaskStore sharedStore] createTask];
                task.taskName = taskString;
            }else{
                NSMutableArray *allTasks = [TaskStore sharedStore].allTasks;
                Task *task = [[TaskStore sharedStore].allTasks objectAtIndex:self.index];
                task.taskName = taskString;
                [allTasks replaceObjectAtIndex:self.index withObject:task];
                //            [self.tableView reloadData];
            }
            
            [self.tableView reloadData];
        }
    }
}

// 点击确定修改任务
- (void)alertView:(UIAlertView *)alertView willChangeWithButtonIndex:(NSInteger)buttonIndex cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (buttonIndex == 1) {
        
        NSString *taskString = [alertView textFieldAtIndex:0].text;
        if (![taskString isEqualToString:@""]) {
            NSMutableArray *allTasks = [TaskStore sharedStore].allTasks;
            Task *task = [[TaskStore sharedStore].allTasks objectAtIndex:indexPath.row];
            task.taskName = taskString;
            [allTasks replaceObjectAtIndex:indexPath.row withObject:task];
//            [self.tableView reloadData];
            NSLog(@"indexPath:%d",(int)indexPath.row);
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

// 获取TODO列表的数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[TaskStore sharedStore] allTasks].count;
}

// 获取某一行的任务
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Task *task = [[TaskStore sharedStore].allTasks objectAtIndex:indexPath.row];
    cell.textLabel.text = task.taskName;
    if ([task.completed isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

// 滑动列表项 删除任务
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Task *task = [[TaskStore sharedStore].allTasks objectAtIndex:indexPath.row];
        
        // 删除任务
        [[TaskStore sharedStore] removeTask:task];
        
        // 删除列表项
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// 点击列表项，对任务进行修改
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Task *task = [[TaskStore sharedStore].allTasks objectAtIndex:indexPath.row];
//    if ([task.completed isEqualToNumber:[NSNumber numberWithBool:YES]]) {
//        task.completed = [NSNumber numberWithBool:NO];
//    } else {
//        task.completed = [NSNumber numberWithBool:YES];
//    }
    // 修改弹窗
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"修改任务"
                                                 message:@"对你的任务进行修改"
                                                delegate:self
                                       cancelButtonTitle:@"取消"
                                       otherButtonTitles:@"确定", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av show];
    
    
    self.index = indexPath.row;
    self.isAdd = NO;
    
    [self.tableView reloadData];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
