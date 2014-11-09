//
//  main.m
//  CalendarDemo
//
//  Created by Joker on 14-10-11.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCalendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //获取当前年，月
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *now;
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        now=[NSDate date];
        comps = [calendar components:unitFlags fromDate:now];
        int year = (int)[comps year];
        int month = (int)[comps month];
        
        //根据参数个数来判断参数是否正确
        switch (argc) {
            case 2: {
                //第一个参数不是‘cal’，就输出错误信息
                const char* arg1 = argv[1];
                if ( strcmp(arg1, "cal") != 0 ) {
                    NSLog(@"无效的参数");
                    break;
                }
                NSLog(@"----当月的日历----");
                [MyCalendar showCalOfYear:year Month:month];
                break;
            }
            case 3: {
                const char* arg1 = argv[1];
                if ( strcmp(arg1, "cal") != 0 ) {
                    NSLog(@"无效的参数");
                    break;
                }
                const char* arg2 = argv[2];
                if ( [MyCalendar isYear:arg2] ) {
                    NSLog(@"----%s年的日历----", arg2);
                    [MyCalendar showCalOfYear:atoi(arg2)];
                }
                else {
                    NSLog(@"无效的参数");
                }
                break;
            }
            case 4: {
                const char* arg1 = argv[1];
                if ( strcmp(arg1, "cal") != 0 ) {
                    NSLog(@"无效的参数");
                    break;
                }
                const char* arg2 = argv[2];
                const char* arg3 = argv[3];
                if ( strcmp(arg2, "-m") == 0 ) {
                    if ( [MyCalendar isMon:arg3] ) {
                        NSLog(@"---今年%s月的日历---", arg3);
                        [MyCalendar showCalOfYear:year Month:atoi(arg3)];
                    }
                    else {
                        NSLog(@"无效的参数");
                    }
                }
                else if ( [MyCalendar isMon:arg2] ) {
                    if ( [MyCalendar isYear:arg3] ) {
                        NSLog(@"--%s年%s月的日历--", arg3, arg2);
                        [MyCalendar showCalOfYear:atoi(arg3) Month:atoi(arg2)];
                    }
                    else {
                        NSLog(@"无效的参数");
                    }
                }
                else {
                    NSLog(@"无效的参数");
                }
                break;
            }
            default:
                break;
        }
    }
    return 0;
}

