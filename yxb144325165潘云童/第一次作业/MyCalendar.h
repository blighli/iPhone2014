//
//  MyCalendar.h
//  CalendarDemo
//
//  Created by Joker on 14-10-11.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

//1～12月每个月的天数，分闰年和非闰年
static const int DaysOfMon[2][12] = { {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
                          {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31} };

@interface MyCalendar : NSObject

//获取某年某月的第一天是星期几
+(int) getFirstWeekdayFromYear:(int)year Month:(int)mon;
//显示某年指定月份的日历
+(void) showCalOfYear:(int)year Month:(int)mon;
//显示指定年份的日历
+(void) showCalOfYear:(int)x;
//判断参数是否是年份
+(BOOL) isYear:(const char* )year;
//判断参数是否是月份
+(BOOL) isMon:(const char* )mon;

@end
