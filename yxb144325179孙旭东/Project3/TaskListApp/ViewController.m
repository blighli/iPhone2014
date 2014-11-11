//
//  ViewController.m
//  TaskListApp
//
//  Created by  sephiroth on 14/11/9.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize tasks;
NSString *docPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    } else {
        tasks = [[NSMutableArray alloc] init];
    }
    
    if ([tasks count] == 0)
    {
        [tasks addObject:@"在textedit中输入内容，单击insert插入"];
        [tasks addObject:@"滑动cell，单击‘删除’删除cell"];
        [tasks addObject:@"键盘上点击return收起键盘"];
        [tasks addObject:@"单击已有cell获取文本，修改后再次单击已有cell修改内容"];
    }
}

-(void) loadView
{
    [super loadView];
    CGRect tableFrame = CGRectMake(0, 80, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    //创建并设置表格
    taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [taskTable setDataSource:self];
    [taskTable setDelegate:self];
    taskTable.allowsSelection = YES;
    //创建并设置文本框
    taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task, tap Insert"];
    taskField.delegate =self;
    //创建并设置按钮
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonFrame];
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    [insertButton addTarget:self action:@selector(addTask:)forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:taskTable];
    [self.view addSubview:taskField];
    [self.view addSubview:insertButton];
    [self.view setBackgroundColor:
     [UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addTask:(id)sender
{
    NSString *text = [taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""])
    {
        return; //如果是空的什么也不做
    }
    [tasks addObject: text]; //将新的任务添加到模型
    [taskTable reloadData]; //表格视图重新载入数据
    [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    NSString *text = [taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""])
    {
        [taskField becomeFirstResponder];
        taskField.text=tasks[indexPath.row];
        return; //如果是空的什么也不做
    }
    [tasks replaceObjectAtIndex:indexPath.row withObject: text]; //将新的任务添加到模型
    [taskTable reloadData]; //表格视图重新载入数据
    [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
    
    //return YES;
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tasks removeObjectAtIndex: indexPath.row];
    [taskTable reloadData];
    /*
     if(indexPath ==0)
     {
     [tableView setEditing:NO animated:YES];
     }
     */
}

//先设置Cell可移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//当两个Cell对换位置后
- (void)tableView:(UITableView*)tableView moveRowAtIndexPath:(NSIndexPath*)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}

@end
