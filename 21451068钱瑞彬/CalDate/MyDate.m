//
//  MyDate.m
//  CalDate
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyDate.h"


@implementation MyDate

const char* WeekDay = "日 一 二 三 四 五 六";
const char* Month[] = {"", "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"};
const char* MonthFormat[] =
{"",
"        一月        ", "        二月        ", "        三月        ",
"        四月        ", "        五月        ", "        六月        ",
"        七月        ", "        八月        ", "        九月        ",
"        十月        ", "       十一月       ", "       十二月       "};


//设置年月
- (void) setYear: (int)year andMonth: (int)month {
    _year = year;
    _month = month;
}


//获取year年的month月有多少天
- (int) MonthRange:(int)year : (int)month {
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* date = [calendar dateFromComponents:components];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
   
    //printf("%d\n",(int)range.length);
    return (int)range.length;
}


//生成year年month月的月历
- (NSMutableArray*) createMonth:(int)year : (int)month {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* date = [calendar dateFromComponents:components];
    
    int firstDay = (int)[calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date]; //1号是一周的第几天
    int range = [self MonthRange:year :month];
    int count = 0; //记录行数
    
    //生成日历格式
    for(int i=1; i<=range; firstDay = 1) {
        NSMutableString* temp = [[NSMutableString alloc] init];
        if(firstDay != 1) {
            [temp appendString:@"  "];
            for(int j=2; j<firstDay; j++) [temp appendString:@"   "];
        }
        int offset;
        for(offset=firstDay; offset<=7 && i+offset-firstDay <= range; offset++) {
            int day = i+offset-firstDay;
            if(offset != 1) [temp appendString:@" "];
            if(day<10)  [temp appendString: [NSString stringWithFormat:@" %d",day] ];
            else        [temp appendString: [NSString stringWithFormat:@"%d",day] ];
        }
        while(offset++ <= 7) [temp appendString:@"   "];
        
        i += (7-firstDay)+1;
        count++;
        [array addObject:temp];
    }
    while(count++ < 6) [array addObject:@"                    "];
    
    return array;
}


//输出月历
-(void) printMonth
{
    NSMutableString* title = [NSMutableString stringWithUTF8String:Month[_month]];
    [title appendFormat:@" %d", _year];
    int offset = (_month)>10 ? 3: 2;
    int blankSpace = (20 - (int)[title length] - offset) / 2;
    while(blankSpace--) [title insertString:@" " atIndex:0];
    
    printf("%s\n", [title UTF8String]);
    printf("%s\n", WeekDay);
    NSMutableArray* array = [self createMonth:_year :_month];
    for(NSString* s in array) {
        printf("%s\n", [s UTF8String]);
    }
}


//输出年历
- (void) printYear
{
    NSMutableString* title = [NSMutableString stringWithFormat:@"%d",_year];
    int blankSpace = (64 - (int)[title length])/2;
    while(blankSpace--) [title insertString:@" " atIndex:0];
    
    printf("%s\n\n",[title UTF8String]);
    
    NSMutableArray* array[13];
    for(int i=1; i<=12; i++) {
        array[i] = [self createMonth:_year: i];
    }
    for(int i=1; i<=12; i+=3) {
        printf("%s  %s  %s\n", MonthFormat[i], MonthFormat[i+1], MonthFormat[i+2]);
        printf("%s  %s  %s\n", WeekDay , WeekDay , WeekDay);
        for(int j=0; j<6; j++) {
            printf("%s  ", [[array[i] objectAtIndex:j] UTF8String]);
            printf("%s  ", [[array[i+1] objectAtIndex:j] UTF8String]);
            printf("%s\n", [[array[i+2] objectAtIndex:j] UTF8String]);
        }
    }
}


//年份是否合法
- (BOOL) isLegalYear : (int) year {
    if(year<1 || year>9999) return NO;
    return YES;
}


//月份是否合法
- (BOOL) isLegalMonth : (int) month {
    if(month<1 || month>12) return NO;
    return YES;
}


//输入非法
//ErrorCode
//
//cal
//  no BUG
//
//cal abc
//  cal: year abc not in range 1..9999
//
//cal -m abc
//  cal: month abc not in range 1..12
//
//cal aaa bbb
//  cal: month aaa not in range 1..12 , year bbb not in range 1..9999
//cal 12 bbb
//  cal: year bbb not in range 1..9999
//cal aaa 2014
//  cal: month aaa not in range 1..12
//
//cal 1 2 3 4
//  cal: illegal option
//  usage: cal [-m month] [month year] [year]
- (void) errorCode: (enum ErrorCode) errorCode andErrorYear: (const char*) erroryear andErrorMonth: (const char*) errormonth {
    switch (errorCode) {
        case ERROR_YEAR:
            printf("cal: year %s not in range 1..9999\n", erroryear);
            break;
        case ERROR_MONTH:
            printf("cal: month %s not in range 1..12\n", errormonth);
            break;
        case ERROR_YEAR_MONTH:
            printf("cal: month %s not in range 1..12 , year %s not in range 1..9999\n", errormonth, erroryear);
            break;
        case ERROR_OTHER:
            printf("cal: illegal option\n");
            printf("usage: cal [-m month] [month year] [year]\n");
            break;
        default:
            printf("cal: illegal option");
            printf("usage: cal [-m month] [month year] [year]\n");
            break;
    }
}

@end
