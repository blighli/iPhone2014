//
//  PrintGregorianCal.m
//  project1
//
//  Created by zack on 14-10-9.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import "PrintGregorianCal.h"

@implementation PrintCal


+ (int) printCalByMonthAndYear:(int)month :(int)year {
    if (month < 1 || month > 12) {
        printf("月份必须为大于0且小于13的整数\n用法：[month] [year] 或 -m [month]\n");
        return -1;
    }
    if (year < 1583 ) {
        printf("年份必须为大于1582且小于2147483647的整数(格里高利历从1582年开始使用)\n用法：[month] [year] 或 [year]\n");
        return -1;
    }
    printf("          %d月    %d年\n",month,year);
    printf(" 日   一   二   三   四   五   六\n");
    //计算平闰年
    int days;
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        days = 31;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
        days = 30;
    } else {
        if ((year %4 == 0 && year % 100 != 0)||year % 400 == 0) {//非常大的年份的平闰年未考虑
            days = 29;
        } else {
            days = 28;
        }
    }
    //运用Zeller公式计算格里高利历的星期
    if (month == 1 || month == 2) {
        year --;
        month += 12;
    }
    int c = year/100;
    int y = year-c*100;
    int week = (c/4)-2*c+(y+y/4)+(13*(month+1)/5);
    while( week<0 ){ week += 7; }
    week %= 7;
    //按格式打印月历
    for (int i = 0; i < week; i ++) {
        printf("     ");
    }
    for (int i = 1; i <= days; i ++) {
        if (i < 10) {
            printf("  %d  ",i);
        }else {
            printf(" %d  ",i);
        }
        if ((i + week) % 7 == 0 && i != days) {
            printf("\n");
        }
    }
    printf("\n");
    return 1;
}

+ (void) printCalByNow {
    NSCalendarDate *now = [NSCalendarDate date];
    [PrintCal printCalByMonthAndYear:(int)[now monthOfYear] :(int)[now yearOfCommonEra]];
}

+ (void) printCalByMonth:(int)month {
    NSCalendarDate *now = [NSCalendarDate date];
    [PrintCal printCalByMonthAndYear:month :(int)[now yearOfCommonEra]];
}

+ (void) printCalByYear:(int)year {
    for (int i = 1; i <13; i++) {
        if([PrintCal printCalByMonthAndYear:i :year] == -1)
            return;
        if (i < 12) {
            printf("\n");
        }
    }
}
@end
