//
//  TaskStore.h
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage-Extensions.h"

@class Task;
@interface TaskStore : NSObject{
    
    NSMutableArray *_allTasks; // TODO
}

@property (nonatomic) int indexState;// 下标
@property (nonatomic) bool isDoop;
@property (nonatomic,copy) UIImage *doop;

+ (TaskStore *)sharedStore;
- (NSMutableArray *)allTasks;
- (Task *)createTask;
- (void)removeTask:(Task *)task;


- (void)save;
@end
