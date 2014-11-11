//
//  ViewController.m
//  TableList
//
//  Created by 陈晟豪 on 14/11/7.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *array;
}

NSString *docPath(void);
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist)
    {
        array = [plist mutableCopy];
    }
    else
    {
        array = [[NSMutableArray alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回tableView的行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

//将数据填充进taskView的单元格中
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *taskTableIdentifier = @"taskTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             taskTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:taskTableIdentifier];
    }
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

// 点击一行时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *cellText = array[indexPath.row];

    UIAlertView *alert = [[UIAlertView alloc]init];
    alert = [alert initWithTitle:@"修改单元格" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

    // alertViewStyle 样式----一般的文本输入框
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField *alertTextField = [alert textFieldAtIndex:0];
    alertTextField.text = cellText;

    alertTextField.tag = indexPath.row;
    
    // 显示alertView
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 查看点击了alertView里面的哪一个按钮
    if (buttonIndex == 0)
    {
        // 0代表取消按钮
        return;
    }
    else if (buttonIndex == 1)
    {
        // 1代表确定按钮,更新数据源,重新加载数据
        UITextField *alertTextField = [alertView textFieldAtIndex:0];
        NSString *newName = [alertTextField text];
        
        // 空串不修改
        if ([newName isEqualToString:@""])
        {
            return;
        }
        
        // 先更新数组
        NSInteger row = alertTextField.tag;
        [array replaceObjectAtIndex:row withObject:newName];
        
        //将更新后的写入文件
        [array writeToFile:docPath() atomically:YES];
    
        
        // 局部刷新数据 单击可以修改单元格数据
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        NSArray *indexPaths = @[indexPath];
        [self.taskView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    }
}

//tableView的单元上滑动时，拉出删除按钮
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//修改删除按钮的文字
- (NSString*)tableView:(UITableView*)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"删除";
}

//删除单元并更新文件
- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUInteger row = [indexPath row];
        
        //删除数组中对应元素
        [array removeObjectAtIndex:row];
        
        //将删除后的写入文件
        [array writeToFile:docPath() atomically:YES];
        
        //删除tableView中对应数据的单元
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

//写入文件和增加列表单元
- (IBAction)addTask:(id)sender
{
    NSString *currentTask = self.textField.text;
        
    //如果是空的什么也不做
    if ([currentTask isEqualToString:@""])
    {
        return;
    }
    [array addObject:currentTask];
    [self.taskView reloadData];
    
    //清空输入框
    [self.textField setText:@""];
    
    //关闭软键盘
    [self.textField resignFirstResponder];
    
    //写入文件
    [array writeToFile:docPath() atomically:YES];
}


//获取文件路径
NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"task.txt"];
}
@end
