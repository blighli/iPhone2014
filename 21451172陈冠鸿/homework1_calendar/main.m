//
//  main.m
//  cal
//
//  Created by Chen.D.guanhong on 14-10-17.
//  Copyright (c) 2014年 Chen.D.guanhong. All rights reserved.
//
//  只支持1900年后的年份

#import <Foundation/Foundation.h>
#import "calendar.h"

int main(int argc, char *argv[])
{
    struct tm *local_time;
    const time_t now = time(NULL);
    local_time = localtime(&now);
    int year = local_time->tm_year + 1900;
    int month = local_time->tm_mon + 1;
    switch (argc)
    {
        case 1:
            //cal:不加参数直接打印当月月历
            show_month(month, year);
            break;
        case 2:
            //cal year:打印当年月历
            year = atoi(*(argv+1));
            if (year < 1900)
                NSLog(@"illegal year:use 1900-9999.");
            else
            {
                for (month = 1; month <= 12;++month)
                    show_month(month, year);
            }
            break;
        case 3:
            //cal -m month: 打印当年指定月份的月历
            if (strcmp(*(argv + 1), "-m") == 0)
            {
                month = atoi(*(argv + 2));
                if (month > 12 || month < 1)
                    NSLog(@"illegal month:use 1-12.");
                else
                    show_month(month, year);
            }
            //cal month year: 打印制定年月的月历
            else if (atoi(*(argv + 1)) <= 12 && atoi(*(argv + 1)) >= 1 && atoi(*(argv + 2)) >= 1900)
            {
                month = atoi(*(argv + 1));
                year = atoi(*(argv + 2));
                show_month(month, year);
            }
            else
                NSLog (@"illegal input!");
            break;
        default:
            break;
    }
    return 0;
}

