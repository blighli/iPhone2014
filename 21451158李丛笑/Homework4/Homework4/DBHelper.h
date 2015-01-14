//
//  DBHelper.h
//  Homework4
//
//  Created by 李丛笑 on 15/1/8.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#ifndef Homework4_DBHelper_h
#define Homework4_DBHelper_h
#import <sqlite3.h>

@interface DBHelper : NSObject
{
    sqlite3 *database;
}
-(NSString *)CreateDB;
-(NSString *)InsertDB:(NSString *)contentid Title:(NSString *)title Text:(NSString *)text ;
-(NSString *)QueryDB;
-(NSString *)DeleteDB;
-(NSString *)deleteData:(NSString *)contendid;
@end


#endif
