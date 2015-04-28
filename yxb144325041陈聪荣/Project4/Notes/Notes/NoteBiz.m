//
//  NoteBiz.m
//  Notes
//
//  Created by 陈聪荣 on 14/12/1.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "NoteBiz.h"

@implementation NoteBiz

//插入Note方法
-(NSMutableDictionary*) createNote:(Note*)model
{
    NoteDao *dao = [NoteDao sharedManager];
    [dao create:model];
    
    return [dao findAllByType];
}

//删除Note方法
-(NSMutableDictionary*) remove:(Note*)model
{
    NoteDao *dao = [NoteDao sharedManager];
    [dao remove:model];
    
    return [dao findAllByType];
}

//编辑Note方法
-(NSMutableDictionary*) edit:(Note*)model
{
    NoteDao *dao = [NoteDao sharedManager];
    [dao modify:model];
    return [dao findAllByType];
}

//查询所用数据方法
-(NSMutableDictionary*) findAll
{
    NoteDao *dao = [NoteDao sharedManager];
    return [dao findAllByType];
}
@end
