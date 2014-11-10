//
//  TaskStore.h
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Task;
@interface TaskStore : NSObject{
    
    NSMutableArray *_allTasks; // TODO
}

+ (TaskStore *)sharedStore;
- (NSMutableArray *)allTasks;
- (Task *)createTask;
- (void)removeTask:(Task *)task;


- (void)save;
@end
