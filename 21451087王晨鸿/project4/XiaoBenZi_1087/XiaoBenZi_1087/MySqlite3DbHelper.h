
//
//  MySqlite3DbHelper.h
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-22.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import<UIKit/UIKit.h>
#import <sqlite3.h>

@interface MySqlite3DbHelper : NSObject
{
    
}
+(NSString*)dbPathforDbName:(NSString*)dbName;
+(BOOL)createDbbyName:(NSString*)name;
+(BOOL)createTablebySql:(NSString*)sql database:(NSString*)databaseName;
+(BOOL)execSql:(NSString*)sql database:(NSString*)databaseName;
+(BOOL)querySql:(NSString *)sql database:(NSString *)databaseName;
+(NSInteger)queryOneNSIntegerSql:(NSString*)sql database:(NSString*)databaseName;
@end