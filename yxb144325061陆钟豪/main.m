//
//  main.m
//  mycal
//
//  Created by Hao on 14-10-5.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YearCalendar.h"
#import "MonthCalendar.h"
#import "Util.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        if(argc == 1) {
            MonthCalendar* mc = [[MonthCalendar alloc] init];
            [mc calcuate];
            [mc output];
            return 0;
        }
        else if(argc == 2) {
            int year = atoi(argv[1]);
            if(!(MIN_YEAR <= year && year <= MAX_YEAR)) {
                printf("cal: year %d not in range %d...%d\n", year, MIN_YEAR, MAX_YEAR);
                return 1;
            }
            YearCalendar* yc = [[YearCalendar alloc] initWithYear:year];
            [yc calcuate];
            [yc output];
            return 0;
        }
        else if(argc == 3 && strcmp(argv[1], "-m") == 0){
            int month = atoi(argv[2]);
            if(!(MIN_MONTH <= month && month <= MAX_MONTH)) {
                printf("cal: month %d not in range %d...%d\n", month, MIN_MONTH, MAX_MONTH);
                return 1;
            }
            MonthCalendar* mc = [[MonthCalendar alloc] initWithMonth:month];
            [mc calcuate];
            [mc output];
            return 0;
        }
        else if(argc == 3 && argv[1][0] == '-')  {
            printf("cal: illegal option -- %c\n", argv[1][1]);
            printf("usage: cal [[month] year]\n");
            printf("       cal [-m month]\n");
            return 1;
        }
        else if(argc == 3) {
            int month = atoi(argv[1]);
            int year = atoi(argv[2]);
            if(!(MIN_MONTH <= month && month <= MAX_MONTH)) {
                printf("cal: month %d not in range %d...%d\n", month, MIN_MONTH, MAX_MONTH);
                return 1;
            }
            else if(!(MIN_YEAR <= year && year <= MAX_YEAR)) {
                printf("cal: year %d not in range %d...%d\n", year, MIN_YEAR, MAX_YEAR);
                return 1;
            }
            MonthCalendar* mc = [[MonthCalendar alloc] initWithYear:year andMonth:month];
            [mc calcuate];
            [mc output];
            return 0;
        }
        else {
            printf("usage: cal [[month] year]\n");
            printf("       cal [-m month]\n");
            return 1;
        }
    }
}

