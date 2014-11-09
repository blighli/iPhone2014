//
//  main.m
//  project1
//
//  Created by 陈聪荣 on 14-10-8.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MonthUtil.h"
#import "YearUtil.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
        NSDateComponents *comps = [[[NSCalendar alloc]initWithCalendarIdentifier: NSGregorianCalendar] components:unitFlags fromDate:[NSDate date]];
        //根据参数个数判断
        if (argc == 1) {
            NSInteger year = comps.year;
            NSInteger month = comps.month;
            MonthUtil *monthUtil = [MonthUtil new];
            monthUtil.year = year;
            monthUtil.month = month;
            [monthUtil cal];
            [monthUtil print];
        } else if (argc == 2) {
            NSString *str1 = [NSString stringWithUTF8String:argv[1]];
            if ([str1 hasPrefix:@"-"]) {
                if ([str1 isEqualToString:@"-m"]) {
                    printf("需要一个具体的月份值\n");
                } else {
                    printf("错误的参数\n");
                }
            } else {
                NSInteger year = [str1 integerValue];
                if (year>0 && year<10000) {
                    YearUtil *yearUtil = [YearUtil new];
                    yearUtil.year = year;
                    yearUtil.rowMonthCount = 3;
                    [yearUtil cal];
                    [yearUtil print];
                } else {
                    printf("年份参数 %ld 必须在1到9999之间\n",(long)year);
                }
            }
        } else if (argc == 3) {
            NSString *str1 = [NSString stringWithUTF8String:argv[1]];
            NSString *str2 = [NSString stringWithUTF8String:argv[2]];
            if ([str1 hasPrefix:@"-"]) {
                if ([str1 isEqualToString:@"-m"]) {
                    NSInteger year = comps.year;
                    NSInteger month = [str2 integerValue];
                    if (month>=1 && month<=12) {
                        MonthUtil *monthUtil = [MonthUtil new];
                        monthUtil.year = year;
                        monthUtil.month = month;
                        [monthUtil cal];
                        [monthUtil print];
                    } else {
                        printf("月份参数 %ld 必须在1到12之间\n",(long)month);
                    }
                } else {
                    printf("错误的参数\n");
                }
            } else {
                NSInteger month = [str1 integerValue];
                NSInteger year = [str2 integerValue];
                if (year>=1 && year<=9999) {
                    if (month>0 && month<13) {
                        MonthUtil *monthUtil = [MonthUtil new];
                        monthUtil.year = year;
                        monthUtil.month = month;
                        [monthUtil cal];
                        [monthUtil print];
                    } else {
                        printf("月份参数 %ld 必须在1到12之间\n",(long)month);
                    }
                } else {
                    printf("年份参数 %ld 必须在1到9999之间\n",(long)year);
                }
            }
        } else {
            printf("参数个数错误!");
        }
    }
    return 0;
}

