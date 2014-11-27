//
//  NoteDB.h
//  homework4
//
//  Created by yingxl1992 on 14/11/20.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface NoteDB : NSObject
{
     sqlite3 *database;
}

- (sqlite3 *)getDB;

- (void)executeSQLOper:(NSString *)sql;
- (sqlite3_stmt *)executeSQLQuery:(NSString *)sql;
@end
