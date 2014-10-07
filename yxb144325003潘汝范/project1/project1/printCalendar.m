//
//  printCalendar.m
//  project1
//
//  Created by Van on 14-10-6.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "printCalendar.h"

@implementation printCalendar
-(void)printCalendarWith:(NSDateComponents *)comps :(BOOL)inSingMonth{
    [printCalendar printTitle:comps :inSingMonth];
    if([comps year] == 1752 && [comps month] == 9){
        [printCalendar printSpecialMonth:comps :inSingMonth];
    }else{
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        //获取本月的第一天的 date
        NSDate *firstDayOfMonth = [gregorian dateFromComponents:comps];
        //根据 date 获取当月第一天是星期几的 index
        NSUInteger day = [gregorian ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:firstDayOfMonth]-1;
        //    NSLog(@"本月的第一天是星期 %ld",day);
        NSUInteger totalDayNum = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[gregorian dateFromComponents:comps]].length;
        //    NSLog(@"这个月一共有 %ld 天",totalDayNum);
        NSUInteger completeWeekNum = 0;
        NSUInteger leftDayNum = 0;
        if (day == 0) {
            completeWeekNum = totalDayNum/7;
            leftDayNum = totalDayNum-completeWeekNum*7;
        }else{
            completeWeekNum = (totalDayNum -(7-day))/7;
            leftDayNum = totalDayNum-completeWeekNum*7-(7-day);
        }
        NSUInteger dayNum = 0;
        if(day > 0){
            for (int i = 0;i < day; i++) {
                printf("     ");
            }
            for (int i = 0;i <(7 - day); i++) {
                dayNum++;
                printf("  %ld  ",dayNum);
            }
            printf("\n");
        }
        for (int i = 0; i<completeWeekNum; i++) {
            for (int j = 0; j < 7; j++) {
                dayNum++;
                if(dayNum<10){
                    printf("  %ld  ",dayNum);
                }else{
                    printf("  %ld ",dayNum);
                }
                
            }
            printf("\n");
        }
        for (int  i = 0;i<leftDayNum; i++) {
            dayNum++;
            printf("  %ld ",dayNum);
        }
        printf("\n\n");
    }
    
}
+(void)printSpecialMonth:(NSDateComponents *)comps :(BOOL)inSingMonth{
    NSUInteger dayNum = 0;
    for (int i = 0;i < 2; i++) {
        printf("     ");
    }
    for (int i = 0;i <2; i++) {
        dayNum++;
        printf("  %ld  ",dayNum);
    }
    dayNum=13;
    for (int i = 0;i <3; i++) {
        dayNum++;
        printf("  %ld ",dayNum);
    }
    printf("\n");
    for (int i = 0; i<2; i++) {
        for (int j = 0; j < 7; j++) {
            dayNum++;
            printf("  %ld ",dayNum);
            }
             printf("\n");
        }
   
    printf("\n\n");
}
+(void)printTitle:(NSDateComponents *)comps :(BOOL)inSingMonth{
    if(inSingMonth){
        printf("          %s   %ld\n", monthName[[comps month]-1], [comps year]);
    }else{
        printf("            %s   \n", monthName[[comps month]-1]);
        printf("\n");
    }
    printf("%s\n", WeekdayName);
}
+ (long) ConvertToJulian:(NSDateComponents *)comps :(NSUInteger)dayNum
{
    NSInteger month = [comps month];
    NSInteger year = [comps year];
    long a = (14 - month) / 12;
    long y = year + 4800 - a;
    long m = month + 12 * a - 3;
    
    long julianDay = (dayNum + (153 * m + 2)/5 + 365 * y + y/4 - y/100 + y/400 - 32045);
    return julianDay+([comps hour] - 12)/24 + [comps minute]/1440 + [comps second]/86400-2400000.5;
}
@end
