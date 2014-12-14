//
//  HabitBiz.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/8.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "HabitBiz.h"
#import "Habit.h"
#import "math.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation HabitBiz

-(instancetype)init {
    self = [super init];
    _habitArray = [Habit MR_findAll];
    _habitArray = [HabitBiz sortHabit:_habitArray];     // 排序
   return self;
}

-(Habit*)saveHabitWithTitle:(NSString*)title iconKey:(NSString*)iconKey period:(HabitPeriod)period times:(NSNumber*)times {
    NSDate *nowDate = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar]; //日历

    Habit *newHabit = [Habit MR_createEntity];
    newHabit.title = title;
    newHabit.period = [NSNumber numberWithInteger:period];
    newHabit.times = times;
    newHabit.iconKey = iconKey;
    newHabit.createTime = nowDate;
    // 计算periodEndTime
    newHabit.nextPeriodBeginTime = [HabitBiz calculateNextPeriodBeginTimeWithBeginTime:nowDate period:period];
    // 计算nextDoTime
    if(period == HabitPeriodDay) {
        NSTimeInterval interval = (NSTimeInterval)(24 * 60 * 60) / [newHabit.times integerValue];
        NSDate *dayBeginTime = [cal dateFromComponents:[cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate]];
        newHabit.nextDoTime = [cal dateByAddingUnit:NSCalendarUnitSecond value:interval / 2 toDate:dayBeginTime options:0];
        newHabit.surplusTimes = times;
        while([newHabit.nextDoTime timeIntervalSinceDate:nowDate] < 0) {
            newHabit.surplusTimes = [NSNumber numberWithInteger:[newHabit.surplusTimes integerValue] - 1];
            newHabit.nextDoTime = [cal dateByAddingUnit:NSCalendarUnitSecond value:interval toDate:newHabit.nextDoTime options:0];
        }
    }
    else {
        NSTimeInterval surplusTimeInterval = [newHabit.nextPeriodBeginTime timeIntervalSinceDate:nowDate];
        newHabit.nextDoTime = [cal dateByAddingUnit:NSCalendarUnitSecond value:surplusTimeInterval / [newHabit.times integerValue] toDate:nowDate options:0];
        newHabit.surplusTimes = times;
    }
    newHabit.doTime = nil;
    newHabit.skipTime = nil;
    _habitArray = [Habit MR_findAll];
    _habitArray = [HabitBiz sortHabit:_habitArray];     // 排序
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait]; //持久化
    return newHabit;
}

+(NSDate*)calculateNextPeriodBeginTimeWithBeginTime:(NSDate*)beginTime period:(HabitPeriod)period{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *dateComps = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:beginTime];// 获取当前年月日date components，时间单元掩码:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
    NSDate *dayBeginTime;
    NSDate *nextPeriodBeginTime;
    dayBeginTime = [cal dateFromComponents:dateComps]; //截取时分秒
    switch (period) {
        case HabitPeriodDay:
            nextPeriodBeginTime = [cal dateByAddingUnit:NSCalendarUnitDay value:1 toDate:dayBeginTime options:0];
            break;
        case HabitPeriodWeek:
            nextPeriodBeginTime = [cal dateByAddingUnit:NSCalendarUnitWeekday value:1 toDate:dayBeginTime options:0];
            break;
        case HabitPeriodMonth:
            nextPeriodBeginTime = [cal dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:dayBeginTime options:0];
            break;
        case HabitPeriodYear:
            nextPeriodBeginTime = [cal dateByAddingUnit:NSCalendarUnitYear value:1 toDate:dayBeginTime options:0];
            break;
        default:
            break;
    }
    return nextPeriodBeginTime;
}

-(NSInteger)done:(Habit*)habit {
    NSDate *nowDate = [NSDate date];
    habit.doTime = nowDate;
    habit.surplusTimes = [NSNumber numberWithInteger:[habit.surplusTimes integerValue] - 1];
    _habitArray = [HabitBiz sortHabit:_habitArray];     // 排序
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait]; //持久化
    return [_habitArray indexOfObject:habit];
}

-(NSInteger)skip:(Habit*)habit {
    NSDate *nowDate = [NSDate date];
    habit.skipTime = nowDate;
    habit.surplusTimes = [NSNumber numberWithInteger:[habit.surplusTimes integerValue] - 1];
    _habitArray = [HabitBiz sortHabit:_habitArray];     // 排序
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait]; //持久化
    return [_habitArray indexOfObject:habit];
}

+(NSArray*)sortHabit:(NSArray*)habitArray {
    // FIXME changeing NSArray to NSMutableArray is better
    // FIXME store sorted array is better
    return [habitArray sortedArrayUsingComparator:^(id a, id b) {
        Habit *habitA = (Habit*)a;
        Habit *habitB = (Habit*)b;
        NSDate *lastActionTimeA = [habitA lastActionTime];
        NSDate *lastActionTimeB = [habitB lastActionTime];
        if(lastActionTimeA.timeIntervalSince1970 < lastActionTimeB.timeIntervalSince1970)
            return (NSComparisonResult)NSOrderedAscending;
        else if(lastActionTimeA.timeIntervalSince1970 > lastActionTimeB.timeIntervalSince1970)
            return (NSComparisonResult)NSOrderedDescending;
        else
            return (NSComparisonResult)NSOrderedSame;
    }];
}

+(HabitBiz*)getInstance {
    static HabitBiz *instance = nil;
    if(instance == nil)
        instance = [[HabitBiz alloc] init];
    return instance;
}
@end
