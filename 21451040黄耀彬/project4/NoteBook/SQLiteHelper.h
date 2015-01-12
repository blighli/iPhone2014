//
//  SQLiteConnection.h
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface SQLiteHelper : NSObject
+ (sqlite3 *) getDBHandle;
+ (void) relaseDBHandle;
@end
