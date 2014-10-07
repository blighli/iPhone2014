//
//  main.m
//  Project1-Cal
//
//  Created by 黄盼青 on 14-9-30.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PQCal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        //如果输入cal
        if(argc==1)
        {
            NSCalendar *greogorian=[NSCalendar calendarWithIdentifier:NSGregorianCalendar];
            NSDateComponents *currentDateCom=[greogorian components:(NSYearCalendarUnit|NSMonthCalendarUnit) fromDate:[NSDate date]];

            NSUInteger currentYear=[currentDateCom year];
            NSUInteger currentMonth=[currentDateCom month];
            PQCal *cal=[[PQCal alloc] initWithYear:currentYear];
            [cal printCalendarByMonth:currentMonth];
            //输出当月日历
        } else if(argc==2)
        {
            NSUInteger currentYear=atoi(argv[1]);
            if(currentYear<=0 || currentYear>9999)
            {
                printf("Cal: year %ld not in range 1..9999\r\n",currentYear);
            } else
            {
                PQCal *cal=[[PQCal alloc] initWithYear:currentYear];
                [cal printAllYearCalendar];
            }
        }else if(argc==3)
        {
            //如果输入cal -m
            if(strcmp(argv[1],"-m")==0)
            {
                NSCalendar *greogorian=[NSCalendar calendarWithIdentifier:NSGregorianCalendar];
                NSDateComponents *currentDateCom=[greogorian components:(NSYearCalendarUnit|NSMonthCalendarUnit) fromDate:[NSDate date]];

                NSUInteger currentYear=[currentDateCom year];
                NSUInteger currentMonth=atoi(argv[2]);

                if(currentMonth>0 && currentMonth<=12)
                {
                    PQCal *cal=[[PQCal alloc] initWithYear:currentYear];
                    [cal printCalendarByMonth:currentMonth];
                }else
                {
                    printf("%ld is neither a month number (1..12) nor a name\r\n",currentMonth);
                }
            }else
            {
                //如果输入cal 月份 年份
                NSUInteger currentMonth=atoi(argv[1]);
                NSUInteger currentYear=atoi(argv[2]);
                if(currentMonth>0 && currentMonth<=12)
                {
                      if(currentYear>0 && currentYear<9999)
                      {
                          PQCal *cal=[[PQCal alloc] initWithYear:currentYear];
                          [cal printCalendarByMonth:currentMonth];
                      }else
                      {
                          printf("%ld is neither a year number (1..12) nor a name\r\n",currentYear);
                      }
                }else
                {
                    printf("%ld is neither a month number (1..12) nor a name\r\n",currentMonth);
                }
            }
        }else
        {
            printf("cal: illegal option\r\n");
            printf("usage: cal [-jy] [[month] year]\r\n");
            printf("cal [-j] [-m month] [year]\r\n");
        }
    }
    return 0;
}
