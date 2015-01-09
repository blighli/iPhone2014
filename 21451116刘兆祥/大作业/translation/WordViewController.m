//
//  WordViewController.m
//  translation
//
//  Created by Steve on 14-12-27.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import "WordViewController.h"

@interface WordViewController()

@end

@implementation WordViewController
-(void)viewDidLoad
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"Dictionary"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    sqlite3_stmt * statement;
    NSString *sqlselect=[NSString stringWithFormat:@"SELECT * FROM WORD WHERE ID = '%d'",num];
    if (sqlite3_prepare_v2(db, [sqlselect UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *en = (char*)sqlite3_column_text(statement, 1);
            word= [[NSString alloc]initWithUTF8String:en];
            char *zh = (char*)sqlite3_column_text(statement, 2);
            meaning = [[NSString alloc]initWithUTF8String:zh];
        }

    }
    TextView.text=[NSString stringWithFormat:@"单词：%@\n中文意义：%@",word,meaning];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
