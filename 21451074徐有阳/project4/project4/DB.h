//
//  DB.h
//  project4
//
//  Created by xuyouyang on 14/11/23.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DB : NSObject
+ (BOOL)openDataBase;
+ (sqlite3_stmt *)executeSelectQuery:(NSString *)query;
+ (void)executeQuery:(NSString *)query;
@end
