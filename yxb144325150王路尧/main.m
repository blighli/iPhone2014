//
//  main.m
//  Project_1
//
//  Created by 王路尧 on 14-10-10.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "calendar.h"


int main(int argc, const char * argv[]) {
    
    calendar *week;
    week=[calendar new];
    int year=0;
    int month=0;
    NSString *s_year;
    NSString *s_month;
    
    
    NSDate *dateNow;
    dateNow=[NSDate dateWithTimeIntervalSinceNow:0];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    int now_year=(int)[comps year];
    int now_month=(int)[comps month];
    
    switch (argc) {
        case 1:
            [week setYear:now_year];
            [week setMonth:now_month];
            break;
        case 2:
            s_year=[[NSString alloc]initWithUTF8String:argv[1]];
            year=[s_year intValue];
            [week setYear:year];
            break;
        case 3:
            s_year=[[NSString alloc]initWithUTF8String:argv[2]];
            s_month=[[NSString alloc]initWithUTF8String:argv[1]];
            year=[s_year intValue];
            month=[s_month intValue];
            if (month>12||month<1) {
                NSLog(@"输入错误");
                return (0);
            }
            [week setYear:year];
            [week setMonth:month];
            break;
        default:
            NSLog(@"输入格式错误！");
            return (0);
            break;
    }
    [week print];
    
    
    
    
        return 0;
}
