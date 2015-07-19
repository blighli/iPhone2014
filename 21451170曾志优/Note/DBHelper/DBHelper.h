//
//  DBHelper.h
//  Note
//
//  Created by Mac on 14-11-21.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBHelper : NSObject
+(NSString *)dataFilePath;

+(sqlite3 *)getDatabase;

+(void) prepareTable;
+(void)updateDatabase:(NSString *)sql;

+(void) closeDatabase:(sqlite3 *)database;

@end
