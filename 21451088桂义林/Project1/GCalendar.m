//
//  GCalendar.m
//  GCalendar
//
//  Created by YilinGui on 14-10-9.
//  Copyright (c) 2014年 YilinGui. All rights reserved.
//

#import "GCalendar.h"

// Declare private methods.
@interface GCalendar()

+ (NSString*)getTagOfMonth:(NSInteger)_month;

+ (NSString*)getTagOfWeekday:(NSInteger)_weekday;

@end


@implementation GCalendar

+ (void)printCalendarOfMonth:(NSInteger)_month inYear:(NSInteger)_year {
    
    // NSDateComponents对象，用于构建日期信息
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:_year];
    [comps setMonth:_month];
    
    // NSCalendar对象，用于获取某个月第一天是星期几
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    // 获取本月第一天的日期
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setTimeZone:[cal timeZone]];
    [date_formatter setDateFormat:@"M/d/yyyy"];
    NSString *firstDay = [NSString stringWithFormat:@"%ld/%d/%ld", (long)_month, 1, (long)_year];
    NSDate *date = [date_formatter dateFromString:firstDay];
    
    // 获取本月第一天是星期几
    comps = [cal components:(NSWeekdayCalendarUnit) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    // 获取本月有多少天
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSInteger num_of_days_in_month = range.length;
    
    // 输出第一行的月份标识和年份标识
    for (int i = 0; i < 5; ++i) {
        printf(" ");
    }
    printf("%s %ld\n", [[GCalendar getTagOfMonth:_month] UTF8String], _year);
    
    // 输出第二行的星期几标识
    for (int i = 0; i < 7; ++i) {
        printf("%s ", [[GCalendar getTagOfWeekday:i] UTF8String]);
    }
    printf("\n");
    
    // 输出日历的第一行
    for (int i = 0; i < weekday - 1; ++i) {
        printf("   ");
    }
    int day = 1;
    printf(" %d ", day++);
    for (int i = (int)weekday; i < 7; ++i) {
        printf(" %d ", day++);
    }
    
    // 输出剩余行
    int cnt = 7;
    while (day <= num_of_days_in_month) {
        if (cnt % 7 == 0) {
            printf("\n");
        }
        if (day < 10) {
            printf(" %d ", day++);
        } else {
            printf("%d ", day++);
        }
        ++cnt;
    }
    printf("\n\n");
}

+ (void)printCalendarOfYear:(NSInteger)_year {
    
    // NSDateComponents对象，用于构建日期信息
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:_year];
    
    // NSCalendar对象，用于获取某个月第一天是星期几
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    /* 1. 输出第一行的年份标识 */
    for (int i = 0; i < 29; ++i) {
        printf(" ");
    }
    printf("%ld\n\n", _year);
    
    /* 2. 分4大“行”输出，每行3个月 */
    for (int row = 0; row < 4; ++row) {
        
        NSInteger month1 = 3 * row + 1;  // 第一列，月份1
        NSInteger month2 = month1 + 1;  // 月份2
        NSInteger month3 = month1 + 2;  // 月份3
        
        // 日期格式对象，用于构建日期
        NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
        [date_formatter setTimeZone:[cal timeZone]];
        [date_formatter setDateFormat:@"M/d/yyyy"];
        
        // 获取月份1第一天的日期
        NSString *firstDay1 = [NSString stringWithFormat:@"%ld/%d/%ld", (long)month1, 1, (long)_year];
        NSDate *date1 = [date_formatter dateFromString:firstDay1];
        
        // 获取月份2第一天的日期
        NSString *firstDay2 = [NSString stringWithFormat:@"%ld/%d/%ld", (long)month2, 1, (long)_year];
        NSDate *date2 = [date_formatter dateFromString:firstDay2];
        
        // 获取月份3第一天的日期
        NSString *firstDay3 = [NSString stringWithFormat:@"%ld/%d/%ld", (long)month3, 1, (long)_year];
        NSDate *date3 = [date_formatter dateFromString:firstDay3];
        
        // 获取月份1第一天是星期几
        [comps setMonth:month1];
        comps = [cal components:(NSWeekdayCalendarUnit) fromDate:date1];
        NSInteger weekday1 = [comps weekday];
        
        // 获取月份1有多少天
        NSRange range1 = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date1];
        NSInteger num_of_days_in_month1 = range1.length;
        
        // 获取月份2第一天是星期几
        [comps setMonth:month2];
        comps = [cal components:(NSWeekdayCalendarUnit) fromDate:date2];
        NSInteger weekday2 = [comps weekday];
        
        // 获取月份2有多少天
        NSRange range2 = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date2];
        NSInteger num_of_days_in_month2 = range2.length;
        
        // 获取月份3第一天是星期几
        [comps setMonth:month3];
        comps = [cal components:(NSWeekdayCalendarUnit) fromDate:date3];
        NSInteger weekday3 = [comps weekday];
        
        // 获取月份3有多少天
        NSRange range3 = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date3];
        NSInteger num_of_days_in_month3 = range3.length;
        
        //---------------//
        /* 下面开始逐行输出 */
        //---------------//
        
        /* 输出月份标识 */
        for (int i = 0; i < 8; ++i) {
            printf(" ");
        }
        printf("%s", [[GCalendar getTagOfMonth:month1] UTF8String]);  // 月份1
        for (int i = 0; i < 8; ++i) {
            printf(" ");
        }
        printf("  ");
        if (month2 > 10) {  // 对11月、12月特殊处理
            for (int i = 0; i < 7; ++i) {
                printf(" ");
            }
            printf("%s", [[GCalendar getTagOfMonth:month2] UTF8String]);  // 月份2
            for (int i = 0; i < 7; ++i) {
                printf(" ");
            }
            printf("  ");
            for (int i = 0; i < 7; ++i) {
                printf(" ");
            }  /* END for */
            printf("%s\n", [[GCalendar getTagOfMonth:month3] UTF8String]);  // 月份3
        } else {
            for (int i = 0; i < 8; ++i) {
                printf(" ");
            }
            printf("%s", [[GCalendar getTagOfMonth:month2] UTF8String]);  // 月份2
            for (int i = 0; i < 8; ++i) {
                printf(" ");
            }
            printf("  ");
            for (int i = 0; i < 8; ++i) {
                printf(" ");
            }  /* END for */
            printf("%s\n", [[GCalendar getTagOfMonth:month3] UTF8String]);  // 月份3
        }  /* END if-else */
        
        /* 输出星期几标识 */
        for (int i = 0; i < 3; ++i) {
            for (int j = 0; j < 7; ++j) {
                printf("%s ", [[GCalendar getTagOfWeekday:j] UTF8String]);
            }
            printf(" ");
        }
        printf("\n");
        
        /* 输出日历的第一行 */
        NSInteger day1 = 1, day2 = 1, day3 = 1;
        for (int i = 0; i < weekday1 - 1; ++i) {
            printf("   ");
        }
        printf(" %ld ", day1++);
        for (int i = (int)weekday1; i < 7; ++i) {
            printf(" %ld ", day1++);
        }  // 月份1
        printf(" ");
        for (int i = 0; i < weekday2 - 1; ++i) {
            printf("   ");
        }
        printf(" %ld ", day2++);
        for (int i = (int)weekday2; i < 7; ++i) {
            printf(" %ld ", day2++);
        }  // 月份2
        printf(" ");
        for (int i = 0; i < weekday3 - 1; ++i) {
            printf("   ");
        }
        printf(" %ld ", day3++);
        for (int i = (int)weekday3; i < 7; ++i) {
            printf(" %ld ", day3++);
        }  // 月份3
        
        /* 输出剩余行 */
        printf("\n");
        
        while (true) {
            if (day1 > num_of_days_in_month1 &&
                day2 > num_of_days_in_month2 &&
                day3 > num_of_days_in_month3) {
                break;
            }
            
            // 月份1
            for (int i = 0; i < 7; ++i) {
                if (day1 <= num_of_days_in_month1) {
                    if (day1 < 10) {
                        printf(" %ld ", day1++);
                    } else {
                        printf("%ld ", day1++);
                    }  /* END if-else */
                } else {
                    printf("   ");
                }  /* END if-else */
            }  /* END for */
            printf(" ");
            
            // 月份2
            for (int i = 0; i < 7; ++i) {
                if (day2 <= num_of_days_in_month2) {
                    if (day2 < 10) {
                        printf(" %ld ", day2++);
                    } else {
                        printf("%ld ", day2++);
                    }  /* END if-else */
                } else {
                    printf("   ");
                }  /* END if-else */
            }  /* END for */
            printf(" ");
            
            // 月份3
            for (int i = 0; i < 7; ++i) {
                if (day3 <= num_of_days_in_month3) {
                    if (day3 < 10) {
                        printf(" %ld ", day3++);
                    } else {
                        printf("%ld ", day3++);
                    }  /* END if-else */
                } else {
                    printf("   ");
                }  /* END if-else */
            }  /* END for */
            printf("\n");
        }  /* END while */
    }  /* END for */
    printf("\n");
}

// Implementation of private methods
+ (NSString*)getTagOfMonth:(NSInteger)_month {
    static NSArray *MONTH_TAG = nil;
    if (!MONTH_TAG) {
        MONTH_TAG = [NSArray arrayWithObjects:@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月", nil];
    }
    return [MONTH_TAG objectAtIndex:_month-1];
}

+ (NSString*)getTagOfWeekday:(NSInteger)_weekday {
    static NSArray *WEEKDAY_TAG = nil;
    if (!WEEKDAY_TAG) {
        WEEKDAY_TAG = [NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
    }
    return [WEEKDAY_TAG objectAtIndex:_weekday];
}

@end
