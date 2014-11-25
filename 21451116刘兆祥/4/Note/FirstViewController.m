//
//  FirstViewController.m
//  Note
//
//  Created by Steve on 14-11-23.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"Note"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS Memorandum (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";
    [self execSql:sqlCreateTable];
     tasks = [[NSMutableArray alloc] init];
    TableView.delegate=self;
    TableView.dataSource=self;
    NSString *sqlQuery = @"SELECT * FROM Memorandum";
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char*)sqlite3_column_text(statement, 1);
            NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
            [tasks addObject:nsNameStr];
        }
    }
    sqlite3_close(db);
    [TableView reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
}
-(void)insert{
    NSString *text;
    text=TextField.text;
    if ([text isEqualToString:@""]) {
        return; //如果是空的什么也不做
    }
    [tasks addObject: text]; //将新的任务添加到模型
    [TableView reloadData]; //表格视图重新载入数据
    [TextField setText:@""]; //清空输入框
    [TextField resignFirstResponder]; //关闭软键盘
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    index=indexPath.row;
    NSString *taskselect=[tasks objectAtIndex:indexPath.row];
    myAlertView =[[UIAlertView alloc]initWithTitle:@"请输入要修改后的内容,若要删除则为空" message:taskselect delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok",nil];
    myAlertView.alertViewStyle=UIAlertViewStylePlainTextInput;
    [myAlertView show];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"Note"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    NSString *sqlDeleteTable = @"DELETE FROM Memorandum";
    [self execSql:sqlDeleteTable];
    NSString *sql;
    for(int i=0;i<tasks.count;i++)
    {
        sql=[NSString stringWithFormat:@"INSERT INTO Memorandum (name) VALUES ('%@')",[tasks objectAtIndex:i]];
        [self execSql:sql];
        
    }
    sqlite3_close(db);

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"进来了个");
    if(buttonIndex==0){
        //NSLog(@"cancel");
        return;
    }
    //NSLog(@"ok");
    UITextField *tf = [myAlertView textFieldAtIndex:0];
    NSString *text=tf.text;
    //NSLog(@"INPUT:%@", text);
    if([text isEqual:@""]==YES)
        [tasks removeObjectAtIndex:index];
    else
        [tasks replaceObjectAtIndex:index withObject:text];
    
    
    [TableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [TableView dequeueReusableCellWithIdentifier:@"Cell"]; if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]]; [[cell textLabel] setText:item];
    return cell ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
