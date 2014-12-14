//
//  Habit.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/5.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


typedef NS_ENUM(NSInteger, HabitPeriod) {   // 习惯周期
    HabitPeriodDay = 0,
    HabitPeriodWeek,
    HabitPeriodMonth,
    HabitPeriodYear
};

@interface Habit : NSManagedObject

// 标题
@property (nonatomic, retain) NSString * title;
// 图标Key
@property (nonatomic, retain) NSString * iconKey;
// 周期
@property (nonatomic, retain) NSNumber * period;
// 次数
@property (nonatomic, retain) NSNumber * times;

@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSDate * nextDoTime;
@property (nonatomic, retain) NSDate * nextPeriodBeginTime;
@property (nonatomic, retain) NSDate * doTime;
@property (nonatomic, retain) NSDate * skipTime;

// 本周期剩余次数
@property (nonatomic, retain) NSNumber * surplusTimes;

-(NSDate *)lastActionTime;

@end
