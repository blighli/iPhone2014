//
//  ViewController.m
//  TaskList
//
//  Created by Mac on 14-11-8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak) UITableView *taskTable;
@property(nonatomic,weak) UITextField *taskField;
@property(nonatomic,weak) UIButton *insertButton;
@property(nonatomic,weak) UIButton *updateButton;
@property(nonatomic,strong) NSMutableArray *tasks;
@property(nonatomic,strong)    NSArray *plist ;
@property(nonatomic,strong) NSIndexPath * indexPath;
@end

@implementation ViewController

-(NSArray *)plist
{
    if (_plist == nil) {
        _plist = [NSArray array];
        
    }
    return _plist;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self taskListUI];
}
-(void)taskListUI
{
    
    if (_plist!=nil) {
        _tasks = [_plist mutableCopy];
    } else {
        _tasks = [[NSMutableArray alloc] init];
    }
    
    
    if ([_tasks count] == 0) {
        
        [_tasks addObject:@"Walk the dogs"];
        
        [_tasks addObject:@"Feed the hogs"];
        
        [_tasks addObject:@"Chop the logs"];
    }
    
    CGRect tableFrame = CGRectMake(0, 80, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    
    //tableView
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    _taskTable = tableView;
    [_taskTable setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [_taskTable setDataSource:self];
    _taskTable.delegate = self;
    
    //field
    UITextField *textFiled = [[UITextField alloc] initWithFrame:fieldFrame];
    _taskField = textFiled;
    [_taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [_taskField setPlaceholder:@"Type a task, tap Insert"];
    //btn
    _insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_insertButton setFrame:buttonFrame];
    [_insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    
    _updateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_updateButton setFrame:buttonFrame];
    [_updateButton setTitle:@"Update" forState:UIControlStateNormal];

    [_updateButton setHidden:YES];
    
    [_insertButton addTarget:self action:@selector(addTask:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [_updateButton addTarget:self action:@selector(updateTask:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_taskTable];
    [self.view addSubview:_taskField];
    [self.view addSubview:_insertButton];
    [self.view addSubview:_updateButton];
}


NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_taskTable dequeueReusableCellWithIdentifier:@"Cell"]; if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [_tasks objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    // Remove the row from data model
    
    [_tasks removeObjectAtIndex:indexPath.row];
    [_taskTable reloadData]; //表格视图重新载入数据
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *msg = [[NSString alloc] initWithFormat:@"%@",[_tasks objectAtIndex:[indexPath row]]];
    _taskField.text=msg;
    [_insertButton setHidden:YES];
    [_updateButton setHidden:NO];
    _indexPath=indexPath;
   // NSLog(@"%@",msg);
    
}



- (void)addTask:(id)sender {
    NSString *text = [_taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""]) {
        return; //如果是空的什么也不做
    }
    [_tasks addObject: text]; //将新的任务添加到模型
    [_taskTable reloadData]; //表格视图重新载入数据
    [_taskField setText:@""]; //清空输入框
    [_taskField resignFirstResponder]; //关闭软键盘
}

-(void)updateTask:(id)sender{
    NSString *origin=[_tasks objectAtIndex:_indexPath.row];
    NSString *text = [_taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:origin]) {
        [_updateButton setHidden:YES];
        [_insertButton setHidden:NO];
        [_taskField setText:@""]; //清空输入框
        return; //如果是空的什么也不做
    }

    [_tasks insertObject:text atIndex:_indexPath.row];
    [_tasks removeObjectAtIndex:_indexPath.row+1];
    [_taskTable reloadData]; //表格视图重新载入数据
    [_taskField setText:@""]; //清空输入框
    [_taskField resignFirstResponder]; //关闭软键盘
    [_updateButton setHidden:YES];
    [_insertButton setHidden:NO];
}

@end
