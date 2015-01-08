//
//  DB.h
//  Homework4
//
//  Created by 李丛笑 on 14/11/27.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#ifndef Homework4_DB_h
#define Homework4_DB_h
#import <sqlite3.h>

@interface DB : NSObject
{
    sqlite3 *database;
}
-(NSString *)CreateDB;
-(NSString *)InsertDB:(int)number ClassID:(NSString *)classid ClassName:(NSString *)classname;
-(NSString *)QueryDB;
-(NSString *)DeleteDB;
//-(NSString *)SelectbyTitle;
-(NSString *)updateData:(int)number Newtitle:(NSString *)newtitle Newtext:(NSString *)newtext;
-(NSString *)deleteData:(NSString *)number;
-(NSString *)clearUp;
@end



#endif
