//
//  SqliteManage.m
//  NOTEbook
//
//  Created by SXD on 14/12/3.
//  Copyright (c) 2014年 SXD. All rights reserved.
//

#import "SqliteManage.h"
#import <sqlite3.h>

@interface SqliteManage ()
{
    sqlite3 *database;
    sqlite3_stmt *statement;
}
@end

static SqliteManage *mySqliteMent;

@implementation SqliteManage
//创建自身
+ (SqliteManage *) sqliteManage;
{
    if (!mySqliteMent) {
        mySqliteMent = [SqliteManage new];
    }
    [mySqliteMent creatDB];
    return mySqliteMent;
}

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.sqlite"];
}
//创建数据库
- (BOOL)creatDB
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    // 创建一个表CREATE TABLE，防止数据覆盖现有的表IF NOT EXISTS FIELDS
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS "
    "(ROW INTEGER PRIMARY KEY, FIELD_DATA TEXT, IMAGE_LEN INTEGER, IMAGE_DATA BLOB, PAINT_LEN INTEGER, PAINT_DATA BLOB);";
    char *errorMsg;
    if (sqlite3_exec (database, [createSQL UTF8String],NULL, NULL, &errorMsg) != SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table: %s", errorMsg);
    }
    sqlite3_close(database);
    return YES;
}
//增加过着修改（弃用）
- (BOOL) replaceDB :(int) row data:(NSString *) fieldsData
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    // Once again, inline string concatenation to the rescue:
    char *update = "INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA) "
    "VALUES (?, ?);";
    char *errorMsg = NULL;
    //sqlite3_stmt *statement;
    //sqlite3_prepare_v2：准备语句
    if (sqlite3_prepare_v2(database, update, -1, &statement, nil)== SQLITE_OK)
    {
        sqlite3_bind_int(statement, 1, (int)row);
        sqlite3_bind_text(statement, 2, [fieldsData UTF8String], -1, NULL);
    }
    //执行sqlite3_step来更新
    if (sqlite3_step(statement) != SQLITE_DONE)
        NSAssert(0, @"Error updating table: %s", errorMsg);
    sqlite3_finalize(statement);
    
    sqlite3_close(database);
    return YES;
}
//(弃用)
- (BOOL) saveImage :(int) row data:(NSString *) fieldsData data:(UIImage *) image
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    // Once again, inline string concatenation to the rescue:
    char *update = "INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA, IMAGE_LEN, IMAGE_DATA, PAINT_LEN, PAINT_DATA) "
    "VALUES (?, ?, ?, ?);";
    char *errorMsg = NULL;
    //sqlite3_stmt *statement;
    //sqlite3_prepare_v2：准备语句
    if (sqlite3_prepare_v2(database, update, -1, &statement, nil)== SQLITE_OK)
    {
        sqlite3_bind_int(statement, 1, (int)row);
        sqlite3_bind_text(statement, 2, [fieldsData UTF8String], -1, NULL);
        NSData *imageData = UIImagePNGRepresentation(image);//把UIImage类型的参数转换成NSData类型
        NSInteger lenth = [imageData length];
        sqlite3_bind_int(statement, 3, (int)lenth);
        sqlite3_bind_blob(statement, 4, [imageData bytes],(int)lenth , NULL);
    }
    //执行sqlite3_step来更新
    if (sqlite3_step(statement) != SQLITE_DONE)
        NSAssert(0, @"Error updating image: %s", errorMsg);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return YES;
}
//修改或者保存
- (BOOL) saveImageAndPaint :(int) row data:(NSString *) fieldsData image:(UIImage *) image andPaint: (UIImage *) paint
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    // Once again, inline string concatenation to the rescue:
    char *update = "INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA, IMAGE_LEN, IMAGE_DATA, PAINT_LEN, PAINT_DATA) "
    "VALUES (?, ?, ?, ?, ?, ?);";
    char *errorMsg = NULL;
    //sqlite3_stmt *statement;
    //sqlite3_prepare_v2：准备语句
    if (sqlite3_prepare_v2(database, update, -1, &statement, nil)== SQLITE_OK)
    {
        sqlite3_bind_int(statement, 1, (int)row);
        sqlite3_bind_text(statement, 2, [fieldsData UTF8String], -1, NULL);
        
        NSData *imageData = UIImagePNGRepresentation(image);//把UIImage类型的参数转换成NSData类型
        NSInteger lenth = [imageData length];
        sqlite3_bind_int(statement, 3, (int)lenth);
        sqlite3_bind_blob(statement, 4, [imageData bytes],(int)lenth , NULL);
        
        NSData *paintData = UIImagePNGRepresentation(paint);//把UIImage类型的参数转换成NSData类型
        NSInteger paintLenth = [paintData length];
        sqlite3_bind_int(statement, 5, (int)paintLenth);
        sqlite3_bind_blob(statement, 6, [paintData bytes],(int)paintLenth , NULL);
    }
    //执行sqlite3_step来更新
    if (sqlite3_step(statement) != SQLITE_DONE)
        NSAssert(0, @"Error updating image: %s", errorMsg);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return YES;
}
//增加一条记录
- (BOOL) addImageAndPaint:(NSString *) fieldsData image:(UIImage *) image andPaint: (UIImage *) paint
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    // Once again, inline string concatenation to the rescue:
    char *update = "INSERT OR REPLACE INTO FIELDS ( FIELD_DATA, IMAGE_LEN, IMAGE_DATA, PAINT_LEN, PAINT_DATA) "
    "VALUES (?, ?, ?, ?, ?);";
    char *errorMsg = NULL;
    //sqlite3_stmt *statement;
    //sqlite3_prepare_v2：准备语句
    if (sqlite3_prepare_v2(database, update, -1, &statement, nil)== SQLITE_OK)
    {
        //sqlite3_bind_int(statement, 1, (int)row);
        sqlite3_bind_text(statement, 1, [fieldsData UTF8String], -1, NULL);
        
        NSData *imageData = UIImagePNGRepresentation(image);//把UIImage类型的参数转换成NSData类型
        NSInteger lenth = [imageData length];
        sqlite3_bind_int(statement, 2, (int)lenth);
        sqlite3_bind_blob(statement, 3, [imageData bytes],(int)lenth , NULL);
        
        NSData *paintData = UIImagePNGRepresentation(paint);//把UIImage类型的参数转换成NSData类型
        NSInteger paintLenth = [paintData length];
        sqlite3_bind_int(statement, 4, (int)paintLenth);
        sqlite3_bind_blob(statement, 5, [paintData bytes],(int)paintLenth , NULL);
    }
    //执行sqlite3_step来更新
    if (sqlite3_step(statement) != SQLITE_DONE)
        NSAssert(0, @"Error updating image: %s", errorMsg);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return YES;
}
//读取文字
- (NSString *) readDB: ( NSInteger) witchRow
{
    //sqlite3_stmt *statement;
    NSString *name;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    NSString *querySQL = [NSString stringWithFormat: @"select FIELD_DATA from FIELDS where ROW=\"%ld\"",(long)witchRow];
    if (sqlite3_prepare_v2(database,[querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
        }
        //        else{
        //            NSLog(@"找不到文子");
        //        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return name;
}
//读取图片
- (UIImage *) readImage: ( NSInteger) witchRow
{
    UIImage *image;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    NSString *querySQL = [NSString stringWithFormat: @"select IMAGE_LEN, IMAGE_DATA from FIELDS where ROW=\"%ld\"",(long)witchRow];
    if (sqlite3_prepare_v2(database,[querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            int length = sqlite3_column_int(statement, 0);//取出图片数据
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(statement, 1) length:length];
            image = [UIImage imageWithData:data];
        }
        //        else{
        //            NSLog(@"找不到图片");
        //        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    return image;
}
//读取手绘
- (UIImage *) readPaint: ( NSInteger) witchRow
{
    UIImage *image;
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    NSString *querySQL = [NSString stringWithFormat: @"select PAINT_LEN, PAINT_DATA from FIELDS where ROW=\"%ld\"",(long)witchRow];
    if (sqlite3_prepare_v2(database,[querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        if (sqlite3_step(statement) == SQLITE_ROW)
        {
            
            int length = sqlite3_column_int(statement, 0);//取出图片数据
            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(statement, 1) length:length];
            image = [UIImage imageWithData:data];
        }
        //        else{
        //            NSLog(@"找不到PAINT");
        //        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    return image;
}
//删除一条数据
- (BOOL) sqlDelete: (NSInteger) witchRow
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    char *deleta = "DELETE FROM FIELDS WHERE ROW=?";
    if(sqlite3_prepare_v2(database, deleta, -1, &statement, NULL)== SQLITE_OK)
    {
        sqlite3_bind_int(statement, 1, (int)witchRow);
        sqlite3_step(statement);
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    return YES;
}
//查询数据总数
- (NSInteger) sqlCount
{
    NSInteger count=0;
    NSInteger temp;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    char *update = "select ROW from FIELDS";
    
    sqlite3_prepare_v2(database, update, -1, &statement, nil);
    while ((sqlite3_step(statement) == SQLITE_ROW))
    {
        temp = sqlite3_column_int(statement, 0);
        if (count < temp)
        {
            count = temp;
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return count;
}
- (NSMutableArray *) sqlCountArray
{
    NSMutableArray *countArray = [[NSMutableArray alloc] init];
    NSInteger row;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    char *update = "select ROW from FIELDS";
    
    sqlite3_prepare_v2(database, update, -1, &statement, nil);
    while ((sqlite3_step(statement) == SQLITE_ROW))
    {
        row = sqlite3_column_int(statement, 0);
        NSNumber *rowNumber = [NSNumber numberWithInteger:row];
        [countArray addObject:rowNumber];
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return countArray;
}
@end

