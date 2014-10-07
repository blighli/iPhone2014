//
//  DateUtil.m
//  Project1
//
//  Created by Mz on 14-10-7.
//  Copyright (c) 2014年 Zorro M. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil
+ (int)daysOfMonth:(int)month inYear:(int)year {
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        case 2:
            if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
                return 29;
            } else {
                return 28;
            }
    }
    return 0;
}

+ (NSCalendar *)gregorianCalendar {
    return [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
}

+ (NSDateComponents *)componentsFromDate:(NSDate *)date {
    NSCalendar *gregorian = [[self class] gregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
                          NSDayCalendarUnit | NSWeekdayCalendarUnit;
    return [gregorian components:unitFlags fromDate:date];
}

+ (NSDateComponents *)componentsFromYear:(int)year andMonth:(int)month {
    NSDateComponents *newComp = [[NSDateComponents alloc] init];
    newComp.year = year;
    newComp.month = month;
    NSDate *date = [[[self class] gregorianCalendar] dateFromComponents:newComp];
    return [[self class] componentsFromDate:date];
}

+ (NSDateComponents *)componentsFromMonth:(int)month {
    NSDateComponents *today = [[self class] componentsFromDate:[NSDate date]];
    return [[self class] componentsFromYear:(int)today.year andMonth:month];
}

+ (NSDateComponents *)componentsOfThisMonth {
    NSDateComponents *today = [[self class] componentsFromDate:[NSDate date]];
    return [[self class] componentsFromYear:(int)today.year andMonth:(int)today.month];
}
@end
