//
//  TestViewController.m
//  translation
//
//  Created by Steve on 14-12-27.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController()

@end

@implementation TestViewController
-(void)viewDidLoad
{
    i=0;flag=0;
    word=[NSMutableArray arrayWithCapacity:1000];
    meaning=[NSMutableArray arrayWithCapacity:1000];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"Dictionary"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
    NSString *sqlselect=@"SELECT * FROM WORD";
    if (sqlite3_prepare_v2(db, [sqlselect UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *en = (char*)sqlite3_column_text(statement, 1);
            NSString *nsen= [[NSString alloc]initWithUTF8String:en];
            [word addObject:nsen];
            char *zh = (char*)sqlite3_column_text(statement, 2);
            NSString *nszh = [[NSString alloc]initWithUTF8String:zh];
            [meaning addObject:nszh];
        }
        
    }
    if ([word count]==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"生词本为空" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    WordLabel.text=[word objectAtIndex:i];
    MeaningLabel.text=NULL;
    
}
-(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!");
    }
}
-(void)Remember
{
    NSString *sqlinsert=[NSString stringWithFormat:@"DELETE FROM WORD WHERE en='%@'",WordLabel.text];
    [self execSql:sqlinsert];
    if (i==[word count]-1) {
        [self Alert];
    }
    else{
    i++;
    WordLabel.text=[word objectAtIndex:i];
    if (flag) {
        MeaningLabel.text=[meaning objectAtIndex:i];
    }
    }
}
-(void)Forget
{
    
    if (i==[word count]-1) {
        [self Alert];
    }
    else
    {
    i++;
    WordLabel.text=[word objectAtIndex:i];
    if (flag) {
        MeaningLabel.text=[meaning objectAtIndex:i];
    }
    }
}
-(void)ReadChinese
{
    if (!flag) {
        flag=1;
        MeaningLabel.text=[meaning objectAtIndex:i];
    }
    else
    {
        flag=0;
        MeaningLabel.text=NULL;
    }
    
}
-(void)Alert
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"测试结束" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    [self.navigationController popViewControllerAnimated:YES];
    sqlite3_close(db);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end