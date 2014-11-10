//
//  main.m
//  Project1
//
//  Created by 陈晟豪 on 14-10-10.
//  Copyright (c) 2014年 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Calendar *newCalender = [[Calendar alloc]init];
    
        if(argc == 1)
        {
            //输出当月日历
            [newCalender showCalendar:0 setMonth:0 setDay:1];
        }
        else if(argc == 2)
        {
            //年份转换成整数
            int year = atoi(argv[1]);
            if(year>=1 && year<=9999)
            {
                //输出当年日历
                [newCalender showYearCalendar:year];
            }
            else
            {
                //年份越界或错误
                printf("cal: year %s not in range 1..9999\n",argv[1]);
            }

        }
        else if(argc == 3)
        {

            //字符串转换
            NSString *str = [[NSString alloc] initWithUTF8String:argv[1]];
            
            //字符串匹配
            if([str isEqualToString:@"-m"])
            {
                int month = atoi(argv[2]);
                if(month>=1 && month<=12)
                {
                    //输出日历
                    [newCalender showCalendar:0 setMonth:month setDay:1];
                }
                else
                {
                    //输出错误
                    printf("cal: %s is neither a month number (1..12) nor a name\n",argv[2]);
                }
            }
            else
            {
                int month = atoi(argv[1]);
                if(month>=1 && month<=12)
                {
                    int year = atoi(argv[2]);
                    if(year>=1 && year<=9999)
                    {
                        //输出日历
                        [newCalender showCalendar:year setMonth:month setDay:1];
                    }
                    else
                    {
                        //年份越界或错误
                        printf("cal: year %s not in range 1..9999\n",argv[2]);
                    }
                }
                else
                {
                    //输出错误
                    printf("cal: %s is neither a month number (1..12) nor a name\n",argv[1]);
                }
            }
        }
        else
        {
            //输出错误
            printf("usage: cal [[month] year]\n");
            printf("       cal [-m month] [year])\n");
        }
        return 0;
    }
}
