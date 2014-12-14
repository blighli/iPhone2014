//
//  Habit.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/5.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "Habit.h"


@implementation Habit

@dynamic title;
@dynamic iconKey;
@dynamic period;
@dynamic times;
@dynamic createTime;
@dynamic doTime;
@dynamic skipTime;
@dynamic nextDoTime;
@dynamic nextPeriodBeginTime;
@dynamic surplusTimes;

-(NSDate *)lastActionTime {
    return [NSDate dateWithTimeIntervalSince1970:fmax(fmax([self.createTime timeIntervalSince1970],
                                                    self.doTime == nil ? 0 :[self.doTime timeIntervalSince1970]),
                                                    self.skipTime == nil ? 0 :[self.skipTime timeIntervalSince1970])];
}

@end
