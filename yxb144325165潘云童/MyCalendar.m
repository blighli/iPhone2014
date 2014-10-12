//
//  MyCalendar.m
//  CalendarDemo
//
//  Created by Joker on 14-10-11.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

#import "MyCalendar.h"

@implementation MyCalendar

const char *Mon[12] = { "Jan.", "Feb.", "Mar.", "Apr.", "May.", "Jun.", "Jul.", "Aug.", "Sep.", "Oct.", "Nov.", "Dec." };

//获取某年某月的第一天是星期几
+(int) getFirstWeekdayFromYear:(int)x Month:(int)y {
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:y];
    [comps setYear:x];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = (int)[weekdayComponents weekday];

    return weekday;
}

//显示某年指定月份的日历
+(void) showCalOfYear:(int)year Month:(int)mon {
    int days;
    if( ((year%4==0) && (year%100!=0)) || (year%400==0) )
        days = DaysOfMon[1][mon-1];
    else
        days = DaysOfMon[0][mon-1];
    int pos = [MyCalendar getFirstWeekdayFromYear:year Month:mon];
    NSLog(@"日 一 二 三 四 五 六");
    NSMutableString *s = [[NSMutableString alloc] init];
    NSString *dayStr = [[NSString alloc] init];
    
    int day = 1;
    int j = 1;
    while (day <= days) {
        for (int i = 1; i <= 7;) {
            if (day > days) {
                break;
            }
            while ( j < pos ) {
                [s appendString:@"   "];
                j++;
                i++;
            }
            if (day >= 10) {
                dayStr = [NSString stringWithFormat:@"%d ",day];
            }
            else {
                dayStr = [NSString stringWithFormat:@" %d ",day];
            }
            [s appendString: dayStr];
            i++;
            day++;
        }
            NSLog(@"%@", s);
            s = [[NSMutableString alloc] init];
    }
}

//显示指定年份的日历
+(void) showCalOfYear:(int)year {
    for (int mon = 1; mon <= 12; mon++) {
        NSLog(@"********%s********", Mon[mon-1]);
        [MyCalendar showCalOfYear:year Month:mon];
        NSLog(@" ");
    }
}

//判断参数是否是年份
+(BOOL) isYear:(const char* )year {
    for (int i = 0; year[i] != 0; i++) {
        if ( year[i] > '9' || year[i]<'0' )  {
            return NO;
        }
    }
    return YES;
}

//判断参数是否是月份
+(BOOL) isMon:(const char* )mon {
    for (int i = 0; mon[i] != 0; i++) {
        if ( mon[i]>'9' || mon[i]<'0' )  {
            return NO;
        }
    }
    if ( atoi(mon)<=0 || atoi(mon)>12 ) {
        return NO;
    }
    return YES;
}

@end
