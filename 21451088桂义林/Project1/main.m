//
//  main.m
//  GCalendar
//
//  Created by YilinGui on 14-10-9.
//  Copyright (c) 2014年 YilinGui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCalendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
                
        /* 输出当前月的日历 */
        if (argc == 1) {
            
            NSDate *now = [NSDate date];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            NSCalendar *cal = [NSCalendar currentCalendar];
            
            // 本年
            comps = [cal components:(NSYearCalendarUnit) fromDate:now];
            NSInteger current_year = [comps year];
            
            // 本月
            comps = [cal components:(NSMonthCalendarUnit) fromDate:now];
            NSInteger current_month = [comps month];
            
            [GCalendar printCalendarOfMonth:current_month inYear:current_year];
        }
        
        /* 输出指定年份的日历 */
        if (argc == 2) {
            NSString *str_year = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
            NSInteger int_year = [str_year integerValue];
            
            if ([str_year hasPrefix:@"-"]) {
                printf("cal: illegal option\n");
                printf("usage: cal [[month] year]\n");
                printf("       cal -m month\n");
            } else if (int_year < 1 || int_year > 9999) {
                printf("cal: year %ld not in range 1..9999\n", int_year);
            } else {
                [GCalendar printCalendarOfYear:int_year];
            }  /* END if-else */
        }  /* END if */
        
        /* 输出指定年、月的日历 */
        if (argc == 3) {
            NSString *str_option = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
            NSString *str_arg3 = [NSString stringWithCString:argv[2] encoding:NSUTF8StringEncoding];
            
            NSDate *now = [NSDate date];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            NSCalendar *cal = [NSCalendar currentCalendar];
            
            // 本年
            comps = [cal components:(NSYearCalendarUnit) fromDate:now];
            NSInteger current_year = [comps year];
            
            // 第二个参数是命令选项
            if ([str_option hasPrefix:@"-"]) {
                NSInteger int_month = [str_arg3 integerValue];
                if (![str_option isEqual: @"-m"]) {
                    printf("cal: illegal option\n");
                    printf("usage: cal [[month] year]\n");
                    printf("       cal -m month\n");
                } else if (int_month < 1 || int_month > 12) {
                    printf("cal: %s is neither a month number (1..12) nor a name\n", [str_arg3 UTF8String]);
                } else {
                    [GCalendar printCalendarOfMonth:int_month inYear:current_year];
                }  /* END if-else */
                
            } else {  // 第二个参数是月份
                NSInteger int_year = [str_arg3 integerValue];
                NSInteger int_month = [str_option integerValue];
                
                if (int_year < 1 || int_year > 9999) {
                    printf("cal: year %ld not in range 1..9999\n", int_year);
                } else if (int_month < 1 || int_month > 12) {
                    printf("cal: %s is neither a month number (1..12) nor a name\n", [str_option UTF8String]);
                } else {
                    [GCalendar printCalendarOfMonth:int_month inYear:int_year];
                }  /* END if-else */
            }  /* END if-else */
        }  /* END if */
        
        if (argc > 3) {
            printf("usage: cal [[month] year]\n");
            printf("       cal -m month\n");
        }
    }
    return 0;
}
