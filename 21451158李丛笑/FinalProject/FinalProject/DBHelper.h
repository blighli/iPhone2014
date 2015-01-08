//
//  DBHelper.h
//  FinalProject
//
//  Created by 李丛笑 on 15/1/4.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#ifndef FinalProject_DBHelper_h
#define FinalProject_DBHelper_h
#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface DBHelper : NSObject
{
    sqlite3 *coursedb;
}

-(NSString *)CreateDB;
-(NSString *)InsertDB:(NSString *)classid Classname:(NSString *)classname Classtime:(NSString *)classtime;
-(NSString *)QueryDB:(NSString *)classid IfByClassid:(BOOL)ifbytableid;
-(NSString *)DeleteDB:(NSString *)classid IfByTableid:(BOOL)ifbyclassid;



@end


#endif
