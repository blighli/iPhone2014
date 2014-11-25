//
//  NoteViewController.m
//  Note
//
//  Created by Steve on 14-11-24.
//  Copyright (c) 2014年 Steve. All rights reserved.
//
#import "NoteViewController.h"


@implementation NoteViewController

-(void)submit
{
    title=TextField.text;
    content=TextView.text;
    if(!flag)
    {
        Sql =[NSString stringWithFormat:@"UPDATE Note SET name ='%@', content= '%@'  WHERE ID = '%d'", title, content,num];
        [self execSql:Sql];
        sqlite3_close(db);
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    else{Sql =[NSString stringWithFormat:@"INSERT INTO Note ('name', 'content') VALUES ('%@', '%@')", title, content];
    [self execSql:Sql];
    sqlite3_close(db);
    [self.navigationController popViewControllerAnimated:NO];
    }
}
-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"Note"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    if(!flag)//加载原内容
    {
        Sql =[NSString stringWithFormat:@"SELECT * FROM Note WHERE ID = '%d'",num];
        sqlite3_stmt * statement;
        
        if (sqlite3_prepare_v2(db, [Sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *name = (char*)sqlite3_column_text(statement, 1);
                NSString *nsNameStr = [[NSString alloc]initWithUTF8String:name];
                char *neirong=(char*)sqlite3_column_text(statement, 2);
                NSString *nsContent = [[NSString alloc]initWithUTF8String:neirong];
                [TextField setText:nsNameStr];
                [TextView setText:nsContent];
                
            }
        }

    }
    //NSLog(@"bbb");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end