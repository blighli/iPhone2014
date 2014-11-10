//
//  Calender.m
//  Calender
//
//  Created by cstlab on 14-10-14.
//  Copyright (c) 2014年 CB. All rights reserved.
//

#import "Calender.h"

@implementation Calender

const char *BlankLine="                    ";
const char *MonthFormat[] =
{"",
    "        一月        ", "        二月        ", "        三月        ",
    "        四月        ", "        五月        ", "        六月        ",
    "        七月        ", "        八月        ", "        九月        ",
    "        十月        ", "       十一月       ", "       十二月       "};

//设置年月
- (void)setyear: (int)input_year month: (int)input_month{
    _year=input_year;
    _month=input_month;
}

//得到当年当月的天数
- (int) get_month_length:(int)year :(int) month{
    NSDateComponents *com=[[NSDateComponents alloc]init];
    [com setYear:year];
    [com setMonth:month];
    [com setDay:1];
    [com setHour:0];
    [com setMinute:0];
    [com setSecond:0];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDate *date=[calendar dateFromComponents:com];
    NSRange range=[calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    return (int)range.length;
}
//得到当年当月第一天是星期几（返回值为1，代表是星期天）
- (int) get_firstday_of_month:(int)year :(int) month{
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDate* date = [calendar dateFromComponents:components];
    int firstDay = (int)[calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
    return firstDay;
}

-(void) printTargetMonth{
    int numOfday=[self get_month_length:_year :_month];
    int firstdayOfmonth=[self get_firstday_of_month:_year :_month];
    int line=0;
    int offset=firstdayOfmonth;
    for (int i=1; i<=numOfday; i++) {
        if (firstdayOfmonth!=1) {
            while (firstdayOfmonth-->1) {
                printf("   ");
            }
        }
        if (i==1||offset==1) printf("%2d",i);
        else printf("%3d",i);
        offset++;
        if (offset>7) {
            printf("\n");
            line++;
            offset=1;
        }
    }
    int a=0;
    switch (line) {
        case 4:
            printf("%s\n",BlankLine);
            printf("%s\n",BlankLine);
            break;
        case 5:
            a=21-3*offset;
            for(int i=a;i>0;i--){
                printf(" ");
            }
            printf("\n");
            printf("%s",BlankLine);
            break;
        case 6:
            a=21-3*offset;
            for(int i=a;i>0;i--){
                printf(" ");
            }
    }
}
-(void) printTargetYear{
    
}
@end


