//
//  NoteDao.m
//  Notes
//
//  Created by 陈聪荣 on 14/12/1.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "NoteDao.h"

@implementation NoteDao

static NoteDao *sharedManager = nil;

+ (NoteDao*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
        [sharedManager createEditableCopyOfDatabaseIfNeeded];
        
    });
    return sharedManager;
}


- (void)createEditableCopyOfDatabaseIfNeeded {
    
    NSString *writableDBPath = [self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([writableDBPath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO,@"数据库打开失败。");
    } else {
        char *err;
        NSString *createSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS Note (cdate TEXT PRIMARY KEY, content TEXT, img BLOB ,type INTEGER);"];
        if (sqlite3_exec(db,[createSQL UTF8String],NULL,NULL,&err) != SQLITE_OK) {
            sqlite3_close(db);
            NSAssert1(NO, @"建表失败, %s", err);
        }
        sqlite3_close(db);
    }
}

- (NSString *)applicationDocumentsDirectoryFile {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentDirectory stringByAppendingPathComponent:DBFILE_NAME];
    
    return path;
}


//插入Note方法
-(int) create:(Note*)model
{
    
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO,@"数据库打开失败。");
    } else {
        
        NSString *sqlStr = @"INSERT OR REPLACE INTO note (cdate, content , img ,type) VALUES (?,?,?,?)";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *nsdate = [dateFormatter stringFromDate:model.date];
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, [nsdate UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [model.content UTF8String], -1, NULL);
            sqlite3_bind_blob(statement, 3, [model.img bytes], (int)[model.img length], NULL);
            sqlite3_bind_int(statement, 4, model.type);

            //执行插入
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"插入数据失败。");
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    
    return 0;
}

//删除Note方法
-(int) remove:(Note*)model
{
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO,@"数据库打开失败。");
    } else {
        
        NSString *sqlStr = @"DELETE  from note where cdate =?";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *nsdate = [dateFormatter stringFromDate:model.date];
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, [nsdate UTF8String], -1, NULL);
            //执行
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"删除数据失败。");
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    
    return 0;
}

//修改Note方法
-(int) modify:(Note*)model
{
    
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO,@"数据库打开失败。");
    } else {
        
        NSString *sqlStr = @"UPDATE note set content=? where cdate =?";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [sqlStr UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *nsdate = [dateFormatter stringFromDate:model.date];
            
            //绑定参数开始
            sqlite3_bind_text(statement, 1, [model.content UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [nsdate UTF8String], -1, NULL);
            //执行
            if (sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"修改数据失败。");
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return 0;
}

//查询所有数据方法
-(NSMutableDictionary*) findAllByType
{
    
    NSString *path = [self applicationDocumentsDirectoryFile];
    NSMutableDictionary *dictData = [[NSMutableDictionary alloc] init];
    
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO,@"数据库打开失败。");
    } else {
        
        NSString *qsql = @"SELECT cdate,content,img,type FROM Note order by cdate desc";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            //分组用
            NSMutableArray *listData1 = [[NSMutableArray alloc] init];
            NSMutableArray *listData2 = [[NSMutableArray alloc] init];
            NSMutableArray *listData3 = [[NSMutableArray alloc] init];
            //执行
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *cdate = (char *) sqlite3_column_text(statement, 0);
                NSString *nscdate = [[NSString alloc] initWithUTF8String: cdate];
                
                char *content = (char *) sqlite3_column_text(statement, 1);
                NSString *nscontent = [[NSString alloc] initWithUTF8String: content];
                
                int length = sqlite3_column_bytes(statement, 2);
                NSData *img = [NSData dataWithBytes:sqlite3_column_blob(statement, 2) length:length];
                
                int type = sqlite3_column_int(statement, 3);
                
                Note* note = [[Note alloc] init];
                note.date = [dateFormatter dateFromString:nscdate];
                note.content = nscontent;
                note.img = img;
                note.type = type;
                
                switch (note.type) {
                    case 1:
                        [listData1 addObject:note];
                        break;
                    case 2:
                        [listData2 addObject:note];
                        break;
                    case 3:
                        [listData3 addObject:note];
                        break;
                }
            }
            [dictData setValue:listData1 forKey:@"文本"];
            [dictData setValue:listData2 forKey:@"照片"];
            [dictData setValue:listData3 forKey:@"绘图"];
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
        
    }
    return dictData;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model
{
    
    NSString *path = [self applicationDocumentsDirectoryFile];
    
    if (sqlite3_open([path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO,@"数据库打开失败。");
    } else {
        
        NSString *qsql = @"SELECT cdate,content,img FROM Note where cdate =?";
        
        sqlite3_stmt *statement;
        //预处理过程
        if (sqlite3_prepare_v2(db, [qsql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            //准备参数
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *nsdate = [dateFormatter stringFromDate:model.date];
            //绑定参数开始
            sqlite3_bind_text(statement, 1, [nsdate UTF8String], -1, NULL);
            
            //执行
            if (sqlite3_step(statement) == SQLITE_ROW) {
                char *cdate = (char *) sqlite3_column_text(statement, 0);
                NSString *nscdate = [[NSString alloc] initWithUTF8String: cdate];
                
                char *content = (char *) sqlite3_column_text(statement, 1);
                NSString * nscontent = [[NSString alloc] initWithUTF8String: content];
                int length = sqlite3_column_bytes(statement, 2);
                NSData *img = [NSData dataWithBytes:sqlite3_column_blob(statement, 2) length:length];
                int type = sqlite3_column_int(statement, 3);
                
                Note* note = [[Note alloc] init];
                note.date = [dateFormatter dateFromString:nscdate];
                note.content = nscontent;
                note.img = img;
                note.type = type;
                
                sqlite3_finalize(statement);
                sqlite3_close(db);
                
                return note;
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
        
    }
    return nil;
}

@end
