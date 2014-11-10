//
//  Task.m
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import "Task.h"


@implementation Task

@dynamic taskName;
@dynamic created;
@dynamic completed;

- (void)awakeFromInsert
{
    self.created = [NSDate date];
    self.completed = [NSNumber numberWithBool:NO];
    self.taskName = @"TODO";
}

@end
