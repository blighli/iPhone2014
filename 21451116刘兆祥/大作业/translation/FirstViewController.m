//
//  FirstViewController.m
//  translation
//
//  Created by Steve on 14-12-24.
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
    NSString *database_path = [documents stringByAppendingPathComponent:@"Dictionary"];
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS WORD (ID INTEGER PRIMARY KEY AUTOINCREMENT, en TEXT,zh TEXT)";
    [self execSql:sqlCreateTable];

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
-(void)search{
    word=Word.text;
    if ([word isEqual:@""]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"输入为空" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    [self TranslateNowLanguage:@"en" TargetLanguage:@"zh" Content:word];
}
//word
//incoming
-(void)insert{
    if (word==NULL) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"输入为空" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];

        return;
    }
     sqlite3_stmt * statement;
    NSString *sqlselect=[NSString stringWithFormat:@"SELECT * FROM WORD WHERE en = '%@'",word];
    if (sqlite3_prepare_v2(db, [sqlselect UTF8String], -1, &statement, nil) == SQLITE_OK)
    {
        if(sqlite3_step(statement) == SQLITE_ROW){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"在生词本中该单词已存在" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
            
        }
    
    else
    {
    NSString *sqlinsert=[NSString stringWithFormat:@"INSERT INTO WORD (en,zh) VALUES ('%@','%@')",word,incoming];
    [self execSql:sqlinsert];
    NSString *sqlQuery = @"SELECT * FROM WORD";
   if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *en = (char*)sqlite3_column_text(statement, 1);
            NSString *nsen = [[NSString alloc]initWithUTF8String:en];
            NSLog(nsen);
        }
    }
    }}
    sqlite3_close(db);
}
-(void)TranslateNowLanguage:(NSString*)NowLanguage TargetLanguage:(NSString*)TargetLanguage Content:(NSString*)Content
{
    NSString *api=[NSString stringWithFormat:@"http://openapi.baidu.com/public/2.0/bmt/translate?client_id=ULdBikbodwAz32Hh1BrmMGEh&q=%@&from=%@&to=%@",Content,NowLanguage,TargetLanguage];
    NSURL *url=[NSURL URLWithString:api];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
     __unused NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];

}
//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
//    NSLog(@"%@",[res allHeaderFields]);
    receiveData = [NSMutableData data];
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}
//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    int head;
    int rear;
//    NSError *error;
    NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",receiveStr);
    NSRange range=[receiveStr rangeOfString:@"dst"];
    head=range.location+6;
    range=[receiveStr rangeOfString:@"}]}"];
    rear=range.location-1;
    range.location=head;
    range.length=rear-head;
    incoming=[receiveStr substringWithRange:range];
    incoming=[self replaceUnicode:incoming];
    TextView.text=[NSString stringWithFormat:@"中文意义:%@",incoming];
    
}
-(NSString *)replaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
                          NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
                          NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                                                mutabilityOption:NSPropertyListImmutable
                                                                                          format:NULL
                                                                                errorDescription:NULL];
                          NSLog(@"%@",returnStr);
                          return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
                          }
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
