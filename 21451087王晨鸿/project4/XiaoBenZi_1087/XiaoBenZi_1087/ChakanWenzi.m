//
//  ChakanWenzi.m
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-21.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChakanWenzi.h"
#import "OnePiece.h"
#import "MySqlite3DbHelper.h"
#import "Constants.h"

@implementation ChakanWenzi



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"hi,i'm in ChakanWenzi");
    
    NSLog(@"whoPastit:%d pastOnepiece: %d , %@, %@, %@",whoPastit, pastOnePiece.iD, pastOnePiece.title, pastOnePiece.type,pastOnePiece.info);
    //如果是查看文字
    if ( [Constants getWhoPastit] == 0 ) {
        //显示传递过来的内容
        _titleField.text = [Constants getPastOnePiece].title;
        _content.text = [Constants getPastOnePiece].info;
    }
    //如果是新建文字
    else
    {
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///点击完成
-(IBAction)finishClick
{
    //设置要插入的内容
    OnePiece * piece = [[OnePiece alloc] init];
    [piece setValue:[_titleField text] forKey:@"title"];
    [piece setValue:@"0" forKey:@"type"];
    [piece setValue:[_content text] forKey:@"info"];
    
    
    
    
    //如果是新建文字
    if ( [Constants getWhoPastit] ==1 ) {
        NSString *insertSql = [NSString stringWithFormat:@"insert into contents(title,type,info) values(\"%@\",\"%@\",\"%@\")",[piece valueForKey:@"title"],[piece valueForKey:@"type"],[piece valueForKey:@"info"]];
        BOOL res = [MySqlite3DbHelper execSql:insertSql database:@"XiaoBenZi_1087.db"];
        if( NO == res )
        {
            NSLog(@"fail!");
        }
        else
            NSLog(@"succeed!");
    }
    //如果是查看文字，则执行update
    else
    {
        NSString *insertSql = [NSString stringWithFormat:@"update contents set title =\"%@\",type=\"%@\",info=\"%@\" where id =\"%ld\"",[piece valueForKey:@"title"],[piece valueForKey:@"type"],[piece valueForKey:@"info"],[Constants getPastOnePiece].iD];
        NSLog(@"update: %@", insertSql);
        BOOL res = [MySqlite3DbHelper execSql:insertSql database:@"XiaoBenZi_1087.db"];
        if( NO == res )
        {
            NSLog(@"fail!");
        }
        else
            NSLog(@"succeed!");
    }
    
}

-(IBAction)deleteClick
{
    //新建
    if (1 == whoPastit) {
        _content.text =@"";
        _titleField.text =@"";
    }
    //查看
    else
    {
        //从数据库中删除文字
        NSString *deleteSql = [NSString stringWithFormat:@"delete from contents where id=\"%d\"",[Constants getPastOnePiece].iD];
        BOOL res = [MySqlite3DbHelper execSql:deleteSql database:@"XiaoBenZi_1087.db"];
        if( NO == res )
        {
            NSLog(@"fail!");
        }
        else
        {
            NSLog(@"succeed!");
        }

    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_titleField resignFirstResponder];
    [_content resignFirstResponder];
}

-(BOOL)querySql:(NSString *)sql database:(NSString *)databaseName
{
    sqlite3 * contactDB;
    sqlite3_stmt *statement;
    int count;
    NSMutableArray * array =[[NSMutableArray alloc] init ];
    @try {
        NSString * databasePath = [MySqlite3DbHelper dbPathforDbName:databaseName];
        const char *dbpath = [databasePath UTF8String];
        
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            NSString *querySQL = sql;//[NSString stringWithFormat:@"SELECT address,phone from contacts where name=\"%@\"",name.text];
            const char *query_stmt = [querySQL UTF8String];
            NSLog(@"sql:%s",query_stmt);
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, nil) == SQLITE_OK)
            {
                NSLog(@"ok");
                while (sqlite3_step(statement) == SQLITE_ROW)
                {

                    
                    NSString* temp =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSLog(@"%@",temp);
                }
                
                sqlite3_finalize(statement);
            }
            
            sqlite3_close(contactDB);
        }
        
        return YES;
    }
    @catch( NSException* ex)
    {
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
        return NO;
    }
}
@end