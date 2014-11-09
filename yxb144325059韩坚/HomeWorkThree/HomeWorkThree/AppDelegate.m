//
//  AppDelegate.m
//  HomeWorkThree
//
//  Created by HJ on 14/11/5.
//  Copyright (c) 2014年 HJ. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    BOOL clickTable;
    int row;
    //NSIndexPath * myIndexPath;
    CGRect bounds;
}

@end

@implementation AppDelegate

NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

//按钮处理事件
- (void)addTask:(id)sender
{
    clickTable = NO;
    [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
}

//按下return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSString *text = [taskField text]; //从输入框获取新的任务
    if ([text isEqualToString:@""])
    {
        clickTable = NO;
    }
    else
    {
        if (clickTable == YES) // 修改
        {
            clickTable = NO;
            [tasks replaceObjectAtIndex:row withObject: text]; //将新的任务添加到模型
            [taskTable reloadData]; //表格视图重新载入数据
            
        }
        else //增加
        {
            [tasks addObject: text]; //将新的任务添加到模型
            [taskTable reloadData]; //表格视图重新载入数据
        }
        //[self reloadcellbackground:myIndexPath];
    }
    [taskField setText:@""]; //清空输入框
    [taskField resignFirstResponder]; //关闭软键盘
    return YES;
}
//textFiled 动画
- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context: nil];
    //[UIView setAnimationDuration: 1.0];
    [UIView setAnimationCurve: UIViewAnimationCurveLinear];
    
    CGRect fieldFrame2 = CGRectMake(10, 40, bounds.size.width-80, 31);
    taskField.frame = fieldFrame2;
    CGRect buttonFrame2 = CGRectMake(bounds.size.width-80, 40, 80, 31);
    insertButton.frame = buttonFrame2;
    
    [UIView commitAnimations];
}
//textFiled 动画
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context: nil];
    //[UIView setAnimationDuration: 1.0];
    [UIView setAnimationCurve: UIViewAnimationCurveLinear];
    
    CGRect fieldFrame3 = CGRectMake(10, 40, bounds.size.width-20, 31);
    taskField.frame = fieldFrame3;
    CGRect buttonFrame2 = CGRectMake(bounds.size.width, 40, 80, 31);
    insertButton.frame = buttonFrame2;
    
    [UIView commitAnimations];
}

//UITableViewDataSource必须实现两个方法:
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}
//UITableViewDataSource必须实现两个方法:
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

////table背景颜色
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    myIndexPath = indexPath;
//    if (indexPath.row%2!=0) {
//        cell.backgroundColor=[UIColor colorWithRed:244/255.0 green:200/255.0 blue:255/255.0 alpha:0.2];
//    }
//}
//
//
//-(void)reloadcellbackground:(NSIndexPath *)indexPath
//{
//    for (NSInteger i = indexPath.row; i<=(NSInteger) [tasks count]; i++)
//    {
//        UITableViewCell *cell = [taskTable  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:indexPath.section]];
//        if (cell)
//        {
//            if (i%2!=0)
//            {
//                cell.backgroundColor=[UIColor colorWithRed:244/255.0 green:200/255.0 blue:255/255.0 alpha:0.2];
//            }
//            else
//            {
//                cell.backgroundColor=[UIColor whiteColor];
//            }
//        }
//    }
//}

//按下table
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    clickTable = YES;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    taskField.text = [tasks objectAtIndex: indexPath.row];
    [taskField becomeFirstResponder];
    row = (int)indexPath.row;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//进入删除模式，按下出现的删除按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        clickTable = NO;
        [tasks removeObjectAtIndex: indexPath.row];
        [taskTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [taskField setText:@""];
        [taskField resignFirstResponder];
        //[self reloadcellbackground:indexPath];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    bounds = [UIScreen mainScreen].bounds;
    clickTable = NO;
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist)
    {
        tasks = [plist mutableCopy];
    }
    else
    {
        tasks = [[NSMutableArray alloc] init];
        [tasks addObject:@"修改：点cell，输入，点return"];
        [tasks addObject:@"删除：向左滑动cell，点删除"];
        [tasks addObject:@"增加：输入，点return"];
        [tasks addObject:@"适配iphone6和6plus"];
    }
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *theWindow = [[UIWindow alloc] initWithFrame: windowFrame];
    [self setWindow: theWindow];
    CGRect tableFrame = CGRectMake(0, 80, bounds.size.width, bounds.size.height-80);
    CGRect fieldFrame = CGRectMake(10, 40, bounds.size.width-20, 31);
    CGRect buttonFrame = CGRectMake(bounds.size.width, 40, 80, 31);
    
    taskTable = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [taskTable setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [taskTable setDataSource:self];
    [taskTable setDelegate: (id)self];
    taskTable.allowsSelection = YES;
    
    taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task, tap return."];
    taskField.delegate = (id)self;
    taskField.backgroundColor = [UIColor colorWithRed:244/255.0 green:200/255.0 blue:255/255.0 alpha:0.2];
    
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonFrame];
    [insertButton setTitle:@"取消" forState:UIControlStateNormal];
    insertButton.titleLabel.font = [UIFont systemFontOfSize: 18.0];
    [insertButton addTarget:self action:@selector(addTask:)forControlEvents:UIControlEventTouchUpInside];
    //[insertButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //insertButton.hidden = YES;
    
    [[self window] addSubview:taskTable];
    [[self window] addSubview:taskField];
    [[self window] addSubview:insertButton];
    [[self window] setBackgroundColor:
    [UIColor whiteColor]];
    [[self window] makeKeyAndVisible];

    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //将缓冲的数据写入到文件中
    [tasks writeToFile:docPath() atomically:YES];
}


@end
