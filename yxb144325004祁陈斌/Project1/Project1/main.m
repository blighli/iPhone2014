//
//  main.m
//  Project1
//
//  Created by xsdlr on 14-9-30.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarUtils.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDateComponents *currentDateComponents = [[[NSCalendar alloc]
                                                    initWithCalendarIdentifier: NSGregorianCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:[NSDate date]];
        //cal
        if (argc == 1) {
            NSInteger year = currentDateComponents.year;
            NSInteger month = currentDateComponents.month;
            CalendarUtils *utils = [CalendarUtils new];
            utils.maxMonthInOneRow = 1;
            utils.isShowYearInFirstLine = NO;
            [utils calcCalendarWithYear:year andMonth:month];
            [utils printCalendar];
        } else if (argc == 2) {//cal 2014
            NSString *argcOneStr = [NSString stringWithUTF8String:argv[1]];
            if ([argcOneStr hasPrefix:@"-"]) {
                //cal -m
                if ([argcOneStr isEqualToString:@"-m"]) {
                    printf("option requires an argument\n");
                } else {
                    printf("illegal option\n");
                    printf("usage: cal [[month] year]\n");
                    printf("       cal [-m month] [year]\n");
                }
            } else {//like cal 2014
                NSInteger year = [argcOneStr integerValue];
                if (year>0 && year<10000) {
                    CalendarUtils *utils = [CalendarUtils new];
                    utils.maxMonthInOneRow = 3;
                    utils.isShowYearInFirstLine = YES;
                    for (NSInteger i=1; i<=12; i++) {
                        [utils calcCalendarWithYear:year andMonth:i];
                    }
                    [utils printCalendar];
                } else {
                    printf("year %ld not in range 1..9999\n",(long)year);
                }
            }
            
        } else if (argc == 3) {
            NSString *argcOneStr = [NSString stringWithUTF8String:argv[1]];
            NSString *argcTwoStr = [NSString stringWithUTF8String:argv[2]];
            if ([argcOneStr hasPrefix:@"-"]) {
                //like cal -m 10
                if ([argcOneStr isEqualToString:@"-m"]) {
                    NSInteger year = currentDateComponents.year;
                    NSInteger month = [argcTwoStr integerValue];
                    if (month>0 && month<13) {
                        CalendarUtils *utils = [CalendarUtils new];
                        utils.maxMonthInOneRow = 1;
                        utils.isShowYearInFirstLine = NO;
                        [utils calcCalendarWithYear:year andMonth:month];
                        [utils printCalendar];
                    } else {
                        printf("month %ld not in range 1..12\n",(long)month);
                    }
                } else {
                    printf("illegal option\n");
                    printf("usage: cal [[month] year]\n");
                    printf("       cal [-m month] [year]\n");
                }
            } else {//cal 10 2014
                NSInteger month = [argcOneStr integerValue];
                NSInteger year = [argcTwoStr integerValue];
                if (year>0 && year<10000) {
                    if (month>0 && month<13) {
                        CalendarUtils *utils = [CalendarUtils new];
                        utils.maxMonthInOneRow = 1;
                        utils.isShowYearInFirstLine = NO;
                        [utils calcCalendarWithYear:year andMonth:month];
//                        NSLog(@"%@",utils->array);
                        [utils printCalendar];
                    } else {
                        printf("month %ld not in range 1..12\n",(long)month);
                    }
                } else {
                    printf("year %ld not in range 1..9999\n",(long)year);
                }
            }
        } else {
            printf("usage: cal [[month] year]\n");
            printf("       cal [-m month] [year]\n");
        }
    }
    return 0;
}
