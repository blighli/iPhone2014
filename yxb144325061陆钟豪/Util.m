//
//  Util.m
//  mycal
//
//  Created by Hao on 14-10-6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "Util.h"

NSString* createMidTitle(NSString* title, NSInteger diplayLenOfTitle, NSInteger length) {
    NSInteger numOfBlank = length - diplayLenOfTitle;
    NSInteger offset = numOfBlank / 2;
    NSMutableString* resultStr = [NSMutableString new];
    for(NSInteger i = 0; i < numOfBlank; ++i) {
        [resultStr appendString:@" "];
    }
    [resultStr insertString:title atIndex:offset];
    return resultStr;
}

static NSInteger dayOfMonth[13] =       {0, 31, 28 ,31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
static NSInteger dayOfLeapMonth[13] =   {0, 31, 29 ,31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
static NSInteger daysOfYear[13] = {0
    , 31
    , 31 + 28
    , 31 + 28 + 31
    , 31 + 28 + 31 + 30
    , 31 + 28 + 31 + 30 + 31
    , 31 + 28 + 31 + 30 + 31 + 30
    , 31 + 28 + 31 + 30 + 31 + 30 + 31
    , 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31
    , 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30
    , 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31
    , 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30
    , 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30 + 31};
static NSInteger daysOfLeapYear[13] = {0
    , 31
    , 31 + 29
    , 31 + 29 + 31
    , 31 + 29 + 31 + 30
    , 31 + 29 + 31 + 30 + 31
    , 31 + 29 + 31 + 30 + 31 + 30
    , 31 + 29 + 31 + 30 + 31 + 30 + 31
    , 31 + 29 + 31 + 30 + 31 + 30 + 31 + 31
    , 31 + 29 + 31 + 30 + 31 + 30 + 31 + 31 + 30
    , 31 + 29 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31
    , 31 + 29 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30
    , 31 + 29 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30 + 31};

NSInteger calcuteDays_old(NSInteger year, NSInteger month, NSInteger day) {
    NSInteger days = ((year - 1) / 4) * (365 * 3 + 366) + ((year - 1) % 4) * 365
        + ((year % 4 == 0) ? daysOfLeapYear[month - 1] : daysOfYear[month - 1]) + day;
    return days;
}

NSInteger calcuteWeekday_old(NSInteger year, NSInteger month, NSInteger day) {
    NSInteger days = calcuteDays_old(year, month, day);
    NSInteger weekday = (days + 5) % 7 + 1;
    return weekday;
}

NSRange calcuteRangeOfMonth_old(NSInteger year, NSInteger month) {
    return NSMakeRange(1, (year % 4 == 0) ? dayOfLeapMonth[month] : dayOfMonth[month]);
}
