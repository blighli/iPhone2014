//
//  TextViewController.m
//  Project4
//
//  Created by CST-112 on 14-11-19.
//  Copyright (c) 2014年 CST-112. All rights reserved.

#import "TextViewController.h"
#import <sqlite3.h>

@interface TextViewController ()<UITextViewDelegate>

@end

@implementation TextViewController

- (NSString *)dataFilePath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.sqlite"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _TextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, self.view.bounds.size.height-220)];
    _TextView.backgroundColor = [UIColor greenColor];
    //[self.TextView setFrame:CGRectMake(0, 0, 100, 100)];
    self.TextView.delegate = self;
    _TextView.hidden = NO;
    [_TextView setFont: [UIFont fontWithName:nil size:20]];
    [self.view addSubview:_TextView ];
    
//    _titleName.frame = CGRectMake(0, 0, 100, 30);
    _titleName.adjustsFontSizeToFitWidth = YES;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
       
    }
    else
        NSLog(@"open sucsessed");
    
    NSString *creatSQL=@"CREATE TABLE IF NOT EXISTS FIELDS (TITLENAME TEXT PRIMARY KEY, FILED_DATA TEXT);";
    char *errorMsg;
    if (sqlite3_exec(database,[creatSQL UTF8String],NULL,NULL,&errorMsg)!=SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0,@"Error creating table:%s",errorMsg);
    }
    else
        NSLog(@"creat sucsessed");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFiledDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}
-(IBAction)background:(id)sender
{
    [self.TextView resignFirstResponder];
    [self.titleName resignFirstResponder];
}

- (IBAction)save:(id)sender {
    char *update="INSERT OR REPLACE INTO FIELDS (TITLENAME,FILED_DATA) VALUES (?,?);";
    char *errorMsg=NULL;
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, update, -1, &stmt, nil)==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [_titleName.text UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [_TextView.text UTF8String], -1, NULL);
    }
    if (sqlite3_step(stmt)!=SQLITE_DONE) {
        NSAssert(0,@"Error updating table:%s",errorMsg);
        sqlite3_finalize(stmt);
    }
    [self showAlert:@"保存完毕！"];
}

- (IBAction)load:(id)sender {
    
        NSString *query=[NSString stringWithFormat:@"SELECT FILED_DATA FROM FIELDS WHERE TITLENAME='%@';",_titleName.text];
        sqlite3_stmt *statment;
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statment, nil)==SQLITE_OK) {
            sqlite3_step(statment);
            
//            while (sqlite3_step(statment) == SQLITE_ROW) {
//                //获得数据
//                int tag = sqlite3_column_int(statment, 0);
//                char *rowData = (char *)sqlite3_column_text(statment, 1);
//                //根据tag获得TextField
//                UITextField *textField = (UITextField *)[self.view viewWithTag:tag];
//                //设置文本
//                textField.text = [[NSString alloc] initWithUTF8String:rowData];
//            }
//            
            char *data=(char *)sqlite3_column_text(statment, 0);
            NSString *filedValue=[[NSString alloc] initWithUTF8String:data];
            _TextView.text=filedValue;
            
            sqlite3_finalize(statment);
            [self showAlert:@"载入完毕！"];
        }else{
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"错误的文件名，请重新输入" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [view show];

        }
}

- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
    
}

- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
@end
