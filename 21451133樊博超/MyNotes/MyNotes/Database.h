//
//  Database.h
//  MyNotes
//
//  Created by 樊博超 on 14-11-24.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#ifndef MyNotes_Database_h
#define MyNotes_Database_h
#import "sqlite3.h"
@interface Database :NSObject
{
    sqlite3  *database;
}
-(void) openDatabase;
-(void)createTable;
-(void)insertTable:(NSString*)name withtext:(NSString*)text;
- (NSMutableArray*)queryTable;
-(void)closeDatabase;
- (NSMutableArray*)queryLine : (NSString*)type withname:(NSString*)name;
-(void)insertTable:(NSString*)name withdata:(NSData*)data;
@end

#endif
