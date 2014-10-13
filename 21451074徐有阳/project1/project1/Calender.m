//
//  Calender.m
//  project1
//
//  Created by xuyouyang on 14-10-12.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calender.h"


@implementation Calender

#pragma mark 某年某月的第一天是周几(周日是0，周一是1...)
- (NSInteger)firstDayOfWeekInYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    comps =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger firstDayOfWeek = [comps weekday];
    return firstDayOfWeek - 1;
}

#pragma mark 某年某月一共有几天
- (NSInteger)dayOfNumberInYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit: NSMonthCalendarUnit forDate: [cal dateFromComponents:comps]];
    return range.length;
}

#pragma mark 根据年月，输出单月日历
- (void)showCalenderWithYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSArray *months = [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"June", @"July", @"Aug", @"Sept", @"Oct", @"Nov", @"Dec", nil];
    NSString *weeks = @"Sun Mon Tue Wed Thu Fri Sat";
    NSString *weekAndYear = [NSString stringWithFormat:@"        %@ %ld", [months objectAtIndex:month - 1], (long)year];
    printf("%s\n", [weekAndYear UTF8String]);
    printf("%s\n", [weeks UTF8String]);
    NSInteger dayOfWeek = [self firstDayOfWeekInYear:year andMonth:month];
    //输出第一天前面的空格
    for (int i = 0; i < dayOfWeek; i++) {
        printf("    ");
    }
    for (int i = 1; i <= [self dayOfNumberInYear:year andMonth:month]; i++) {
        //判断是否为周六
        if (dayOfWeek == 6) {
            if (i <10) {
                printf(" ");
            }
            printf(" %d\n", i);
            dayOfWeek = (dayOfWeek + 1) % 7;
        } else {
            if (i <10) {
                printf(" ");
            }
            printf(" %d ", i);
            dayOfWeek = (dayOfWeek + 1) % 7;
        }
    }
    printf("\n");
}

#pragma mark 根据年份输出整年日历
- (void)showCalenderWithYear:(NSInteger)year
{
    NSArray *months = [NSArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
    NSString *weeks = @"Sun Mon Tue Wed Thu Fri Sat  Sun Mon Tue Wed Thu Fri Sat  Sun Mon Tue Wed Thu Fri Sat";
    printf("                                       %ld\n", (long)year);
    for (int i = 0; i < 12; i = i + 3) {
        // 月份标题
        for (int j = 0; j < 3; j++) {
            printf("            %s              ", [[months objectAtIndex:j+i] UTF8String]);
        }
        printf("\n");
        // 星期标题
        printf("%s\n", [weeks UTF8String]);
        // 每个月的日期
        NSInteger dayOfWeek1 = [self firstDayOfWeekInYear:year andMonth:i + 1];
        NSInteger dayOfWeek2 = [self firstDayOfWeekInYear:year andMonth:i + 2];
        NSInteger dayOfWeek3 = [self firstDayOfWeekInYear:year andMonth:i + 3];
        NSInteger dayNumber1 = [self dayOfNumberInYear:year andMonth:i + 1];
        NSInteger dayNumber2 = [self dayOfNumberInYear:year andMonth:i + 2];
        NSInteger dayNumber3 = [self dayOfNumberInYear:year andMonth:i + 3];
        NSInteger day1 = 1;
        NSInteger day2 = 1;
        NSInteger day3 = 1;
        for (int j = 0; ; j++) {
            // 第一个月前面的空格
            if (day1 == 1) {
                for (int k =0; k < dayOfWeek1; k++) {
                    printf("    ");
                }
            }
            // 第一个月第j行的内容
            for (int k = day1; ; k++) {
                day1++;
                // 判断是否为周六
                if ((k + dayOfWeek1) % 7 == 0) {
                    if (k <10) {
                        printf(" ");
                    }
                    // 判断是否大于当月天数
                    if (k > dayNumber1) {
                        printf("     ");
                    } else {
                        printf(" %d  ", k);
                    }
                    break;
                } else {
                    if (k <10) {
                        printf(" ");
                    }
                    // 判断是否大于当月天数
                    if (k > dayNumber1) {
                        printf("    ");
                    } else {
                        printf(" %d ", k);
                    }
                }
            }
            // 第二个月前面的空格
            if (day2 == 1) {
                for (int k =0; k < dayOfWeek2; k++) {
                    printf("    ");
                }
            }
            // 第二个月第j行的内容
            for (int k = day2; ; k++) {
                day2++;
                // 判断是否为周六
                if ((k + dayOfWeek2) % 7 == 0) {
                    if (k <10) {
                        printf(" ");
                    }
                    // 判断是否大于当月天数
                    if (k > dayNumber2) {
                        printf("     ");
                    } else {
                        printf(" %d  ", k);
                    }
                    break;
                } else {
                    if (k <10) {
                        printf(" ");
                    }
                    // 判断是否大于当月天数
                    if (k > dayNumber2) {
                        printf("    ");
                    } else {
                        printf(" %d ", k);
                    }
                }
            }
            // 第三个月前面的空格
            if (day3 == 1) {
                for (int k =0; k < dayOfWeek3; k++) {
                    printf("    ");
                }
            }            // 第三个月第j行的内容
            for (int k = day3; ; k++) {
                day3++;
                // 判断是否为周六
                if ((k + dayOfWeek3) % 7 == 0) {
                    if (k <10) {
                        printf(" ");
                    }
                    // 判断是否大于当月天数
                    if (k > dayNumber3) {
                        printf("    ");
                    } else {
                        printf(" %d  ", k);
                    }
                    break;
                } else {
                    if (k <10) {
                        printf(" ");
                    }
                    // 判断是否大于当月天数
                    if (k > dayNumber3) {
                        printf("    ");
                    } else {
                        printf(" %d ", k);
                    }
                }
            }
            printf("\n");
            if (day1 > dayNumber1 && day2 > dayNumber2 && day3 > dayNumber3)
                break;
        }
        
        printf("\n");
    }
}

@end