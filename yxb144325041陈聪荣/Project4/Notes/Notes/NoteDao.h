//
//  NoteDao.h
//  Notes
//
//  Created by 陈聪荣 on 14/12/1.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "sqlite3.h"

#define DBFILE_NAME @"NotesList.sqlite3"

@interface NoteDao : NSObject{
    sqlite3 *db;
}

+ (NoteDao*)sharedManager;

- (NSString *)applicationDocumentsDirectoryFile;
- (void)createEditableCopyOfDatabaseIfNeeded;


//插入Note方法
-(int) create:(Note*)model;

//删除Note方法
-(int) remove:(Note*)model;

//修改Note方法
-(int) modify:(Note*)model;

//查询所有数据方法，并根据类型分组
-(NSMutableDictionary*) findAllByType;

//按照主键查询数据方法
-(Note*) findById:(Note*)model;



@end
