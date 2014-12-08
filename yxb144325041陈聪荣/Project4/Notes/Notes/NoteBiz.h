//
//  NoteBiz.h
//  Notes
//
//  Created by 陈聪荣 on 14/12/1.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteDao.h"

@interface NoteBiz : NSObject

//插入Note方法
-(NSMutableDictionary*) createNote:(Note*)model;

//删除Note方法
-(NSMutableDictionary*) remove:(Note*)model;

//编辑Note方法
-(NSMutableDictionary*) edit:(Note*)model;

//查询所用数据方法
-(NSMutableDictionary*) findAll;

@end
