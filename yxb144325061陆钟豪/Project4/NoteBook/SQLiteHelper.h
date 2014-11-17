//
//  SQLiteConnection.h
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/15.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

// 非线程安全
@interface SQLiteHelper : NSObject
+ (sqlite3 *) getDBHandle;
+ (void) relaseDBHandle;
@end
