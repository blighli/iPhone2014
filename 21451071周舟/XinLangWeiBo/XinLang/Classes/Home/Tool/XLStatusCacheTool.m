//
//  XLStatusCacheTool.m
//  XinLang
//
//  Created by 周舟 on 9/12/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "XLStatusCacheTool.h"
#import "XLStatus.h"
#import "FMDB.h"
#import "XLAccount.h"
#import "XLAccountTool.h"

@implementation XLStatusCacheTool
static FMDatabaseQueue *_queue;

+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    //NSLog(@"path:%@",path);
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, access_token text, idstr text, dict blob);"];
    }];
}

+ (void)addStatuses:(NSArray *)dictArray
{
    for (NSDictionary *dict in dictArray) {
        [self addStatus:dict];
    }
}

+ (void)addStatus:(NSDictionary *)dict
{
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSString *accessToken = [XLAccountTool account].access_token;
        NSString *idstr = dict[@"idstr"];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        
        // 2.存储数据
        [db executeUpdate:@"insert into t_status (access_token, idstr, dict) values(?, ? , ?)", accessToken, idstr, data];
    }];
}

+ (NSArray *)statuesWithParam:(XLHomeStatusParam *)param
{
    // 1.定义数组
    __block NSMutableArray *dictArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        dictArray = [NSMutableArray array];
        
        // accessToken
        NSString *accessToken = [XLAccountTool account].access_token;
        
        FMResultSet *rs = nil;
        if (param.since_id) { // 如果有since_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;", accessToken, param.since_id, param.count];
        } else if (param.max_id) { // 如果有max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0,?;", accessToken, param.max_id, param.count];
        } else { // 如果没有since_id和max_id
            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?;", accessToken, param.count];
        }
        
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"dict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            //NSLog(@"---source:%@",dict[@"source"]);
            [dictArray addObject:dict];
        }
    }];
    
    // 3.返回数据
    return dictArray;
}

//
//+ (void)setup
//{
//    //0
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
//    NSLog(@"%@",path);
//    
//    //1.
//    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
//    //2.
//    [_queue inDatabase:^(FMDatabase *db) {
//        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, access_token text, idstr text, status blob);"];
//        
//    }];
//    
//}

//+(void)addStatus:(XLStatus *)status
//{
//    [self setup];
//    [_queue inDatabase:^(FMDatabase *db) {
//        //1.
//        NSString *accessToken = [XLAccountTool account].access_token;
//        NSString *idstr = status.idstr;
//        
//        //NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
//        //2
//        [db executeUpdate:@"insert into t_status (access_token, idstr, status) values(?, ? , ?)", accessToken, idstr, data];
//    }];
//    [_queue close];
//}

//+ (void)addStatuses:(NSArray *)statusArray
//{
//    for (XLStatus *status in statusArray)
//    {
//        [self addStatus:status];
//        NSLog(@"--status:%@",status);
//        
//    }
//}

//
//+ (NSArray *)statusWithParam:(XLHomeStatusParam *)param
//{
//    NSLog(@"--XLStatusCacheTool--param:%@",param);
//    [self setup];
//    
//    //1.
//    __block NSMutableArray *statusArray = nil;
//    
//    //2.
//    [_queue inDatabase:^(FMDatabase *db) {
//        statusArray = [NSMutableArray array];
//        
//        //
//        NSString *accessToken = [XLAccountTool account].access_token;
//        
//        FMResultSet *rs = nil;
//        if (param.since_id) {
//            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;",accessToken, param.since_id, param.count];
//        }
//        else if(param.max_id)
//        {
//            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0,?;", accessToken, param.max_id, param.count];
//        }
//        else
//        {
//            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?;", accessToken, param.count];
//        }
//        
//        while (rs.next)
//        {
//            NSData *data = [rs dataForColumn:@"status"];
//            //FIXME: 解码错误？？？？？
//            
//            NSDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            NSLog(@"dic:%@",dic);
//            //XLStatus *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            //[statusArray addObject:status];
//        }
//    }];
//    [_queue close];
//    return statusArray;
//}
@end
