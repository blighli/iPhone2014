//
//  main.m
//  Calendar
//
//  Created by guest on 14-10-12.
//  Copyright (c) 2014年 HuangLei. All rights reserved.
//

//======21451175HuangLei==================
//A Calendar
//You can use:"./Calendar" to get calendar of this month
//You can use:"./Calendar -m aMonth"，（e.g ./Calendar -m 10） to get the calendar of a month,which you give in "aMonth",in this year
//You can use:"./Calendar aYear",(e.g ./Calendar 2014) to get all calendars of a year, which you give in "ayear"
//You can use:"./Calendar aMonth inYear", (./Calendar 10 2014) to get the calendar of a month in year, which you give in "aMonth" and "inYear"

#import <Foundation/Foundation.h>
#import "Calendar.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        if(argc == 1)
        {
            //./Calendar
            NSDate *now = [[NSDate alloc] init];
            int nowYear  = [[now dateWithCalendarFormat:nil timeZone:nil] yearOfCommonEra];
            int nowMonth = [[now dateWithCalendarFormat:nil timeZone:nil] monthOfYear];
            Calendar *calendar = [[Calendar alloc] init];
            [calendar calMonth:nowMonth Year:nowYear];
        }
        if (argc == 2)
        {
            //./Calendar aYear, e.g ./Calendar 2014
            NSString *yearStr = [NSString stringWithFormat:@"%s",argv[1]];
            Calendar *calendar = [[Calendar alloc] init];
            int nowYear = [yearStr intValue];
            [calendar calYear:nowYear];
        }
        if (argc == 3)
        {
            NSString *monthStr = [NSString stringWithFormat:@"%s",argv[1]];
            NSString *yearStr = [NSString stringWithFormat:@"%s",argv[2]];
            if ([monthStr isEqualToString:@"-m"])
            {
                //./Calendar -m aMonth, e.g  ./Calendar -m 10
                NSDate *now = [[NSDate alloc] init];
                int nowMonth = [yearStr intValue];
                int nowYear  = [[now dateWithCalendarFormat:nil timeZone:nil] yearOfCommonEra];
                Calendar *calendar = [[Calendar alloc] init];
                [calendar calMonth:nowMonth Year:nowYear];
            }
            else
            {
                //./Calendar aMonth aYear, e.g ./Calendar 10 2014
                int nowMonth = [monthStr intValue];
                int nowYear =  [yearStr intValue];
                Calendar *calendar = [[Calendar alloc] init];
                [calendar calMonth:nowMonth Year:nowYear];
            }
        }
    }
    return 0;
}

