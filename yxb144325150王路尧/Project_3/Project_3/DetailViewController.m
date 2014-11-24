//
//  DetailViewController.m
//  Project_3
//
//  Created by 王路尧 on 14/11/24.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import "DetailViewController.h"
#import <sqlite3.h>

@interface TextViewController ()

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
}

- (IBAction)textFiledDoneEditing:(id)sender
{
    [sender resignFirstResponder];
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
}

- (IBAction)load:(id)sender {
    NSString *query=[NSString stringWithFormat:@"SELECT FILED_DATA FROM FIELDS WHERE TITLENAME='%@';",_titleName.text];
    sqlite3_stmt *statment;
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statment, nil)==SQLITE_OK) {
        sqlite3_step(statment);
        char *data=(char *)sqlite3_column_text(statment, 0);
        NSString *filedValue=[[NSString alloc] initWithUTF8String:data];
        _TextView.text=filedValue;
        
        sqlite3_finalize(statment);
    }
}
@end
