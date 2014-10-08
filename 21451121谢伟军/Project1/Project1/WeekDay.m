//
//  WeekDay.m
//  Project1
//
//  Created by xvxvxxx on 14-10-8.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "WeekDay.h"

@implementation WeekDay

//用输入的日期进行初始化
-(id)initWithInputDayWithYear:(NSInteger)year Month:(NSInteger)month{
    self = [super init];
    if (self) {
        self.year = year;
        self.month = month;
    }
    return self;
}


//用今天的日期进行初始化
-(id)initWithToday{
    self = [super init];
    if (self) {
        NSDate *today = [NSDate date];
        
        
        NSCalendar *defaultCalendar =[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *components = [defaultCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit  |NSDayCalendarUnit  fromDate:today];
        self.year = components.year;
        self.month = components.month;
    }
    return self;
}



//用于查询year年month月的第一天是周几
-(NSInteger)weekDay{
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [comps setDay:1];
    [comps setMonth:self.month];
    [comps setYear:self.year];
    [comps setTimeZone:[NSTimeZone systemTimeZone]];
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSDate *date = [calendar dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger weekday = [weekdayComponents weekday];
    return weekday;
}


//查询各个月份共有多少月
-(NSInteger)numberOfDayInMonth{
    NSInteger numberOfDaysInMonth = 0;
    switch(self.month)
    {
        case 1:
            numberOfDaysInMonth=31;
            break;
        case 2:
            numberOfDaysInMonth=
            ((self.year%4 == 0 && self.year%100 != 0) || (self.year%400 == 0))
            ? 29 : 28 ; //查润月
            break;
        case 3:
            numberOfDaysInMonth=31;
            break;
        case 4:
            numberOfDaysInMonth=30;
            break;
        case 5:
            numberOfDaysInMonth=31;
            break;
        case 6:
            numberOfDaysInMonth=30;
            break;
        case 7:
            numberOfDaysInMonth=31;
            break;
        case 8:
            numberOfDaysInMonth=31;
            break;
        case 9:
            numberOfDaysInMonth=30;
            break;
        case 10:
            numberOfDaysInMonth=31;
            break;
        case 11:
            numberOfDaysInMonth=30;
            break;
        case 12:
            numberOfDaysInMonth=31;
            break;
    }
    return numberOfDaysInMonth;
}

@end