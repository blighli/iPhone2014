//
//  SecondViewController.m
//  NoteBook
//
//  Created by 陈晟豪 on 14/11/21.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import "SecondViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import <sqlite3.h>

@interface SecondViewController ()
{
    AppDelegate *appDelegate;
}

@end

@implementation SecondViewController

//显示列表行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appDelegate.contentArray count];
}

//显示row行数据,即创建并获取UITableViewCell对象
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *taskTableIdentifier = @"diaryTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             taskTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:taskTableIdentifier];
    }
    cell.textLabel.text = appDelegate.titleArray[indexPath.row];
    return cell;
}

//当按下某个表格行时，创建detailViewController对象并将其压入UINavigationController对象的栈
-(void)tableView:(UITableView *)aTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取按下的行号获取ID号
    appDelegate.databaseIndexPath = [indexPath row];
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

//删除单元
- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUInteger row = [indexPath row];
        NSInteger databaseRow = [[appDelegate.numberArray objectAtIndex:row] integerValue];
        
        //删除数组中对应元素
        [appDelegate.numberArray removeObjectAtIndex:row];
        [appDelegate.titleArray removeObjectAtIndex:row];
        [appDelegate.contentArray removeObjectAtIndex:row];
        
        //更新数据库
        char *errorMsg;
        NSString *sqlDelete = [NSString stringWithFormat:@"DELETE FROM FILEDS WHERE ID=%ld",(long)databaseRow];
        if (sqlite3_exec(appDelegate.database, [sqlDelete UTF8String], NULL, NULL, &errorMsg)==SQLITE_OK)
        {
            NSLog(@"删除成功.");
        }
        else
        {
            NSLog( @"删除失败" );
        }
        
        //删除tableView中对应数据的单元
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"我的日记";
    appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)viewWillAppear:(BOOL)animated
{
    //按行号排序获取数据
    NSString *query = @"SELECT * FROM FILEDS ORDER BY ID";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(appDelegate.database, [query UTF8String],
                           -1, &statement, nil) == SQLITE_OK)
    {
        //遍历返回每一行
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            //获取行号
            //char*转NSString
            NSString *row = [[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
            
            if(![appDelegate.numberArray containsObject:row])
            {
                //获取标题和数据
                char *titleData = (char *)sqlite3_column_text(statement, 1);
                char *contentData = (char *)sqlite3_column_text(statement, 2);
                
                //利用获取的数据进行设置
                NSString *titleValue = [[NSString alloc]
                                        initWithUTF8String:titleData];
                NSString *contentValue = [[NSString alloc] initWithUTF8String:contentData];
                
                //添加行号和数据到数组中
                [appDelegate.numberArray addObject:row];
                [appDelegate.titleArray addObject:titleValue];
                [appDelegate.contentArray addObject:contentValue];
            }
        }
        sqlite3_finalize(statement);
    }
    else
    {
        NSLog(@"数据库操作数据失败!");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

@end
