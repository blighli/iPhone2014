//
//  Mycalender.m
//  Calender
//
//  Created by hu on 14-10-7.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import "Mycalender.h"

@implementation Mycalender
//输出当年当月的月历
-(void)showCurrentyearCalender
{
    NSDate * date = [NSDate new];
    NSCalendar * calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents * monthcomponents = [calender components:NSMonthCalendarUnit fromDate:date];
    int months = (int)[monthcomponents month];
    NSDateComponents * yearcomponents = [calender components:NSYearCalendarUnit fromDate:date];
    int years = (int)[yearcomponents year];
    int days = [self getdaysofmonth:years months:months];
    int firstweekday = [self getfirstweekdayofmonth:years months:months];
//    NSLog(@"firstweekday is %d",firstweekday);
    [self printfCalender:days firstday:firstweekday month:months year:years];
    
}

//输出当年某一个月的月历
-(void)showCurrentyearCalender:(int)month
{
    NSDate * date = [NSDate new];
    NSCalendar * calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents * yearcomponents = [calender components:NSYearCalendarUnit fromDate:date];
    int years = (int)[yearcomponents year];
    int days = [self getdaysofmonth:years months:month];
    int firstweekday = [self getfirstweekdayofmonth:years months:month];
    [self printfCalender:days firstday:firstweekday month:month year:years];
    
}

//输出某一年全部的月历
-(void)showyearCalender:(int)year
{
    int days;
    int firstweekday;
    for(int i=1;i<=12;i++)
    {
        days =[self getdaysofmonth:year months:i];
        firstweekday = [self getfirstweekdayofmonth:year months:i];
       [self printfCalender:days firstday:firstweekday month:i year:year];
    }
}

//输出某年某月的月历
-(void)showCalener:(int)year months:(int)month
{
    int days =[self getdaysofmonth:year months:month];
    int firstweekday =[self getfirstweekdayofmonth:year months:month];
//    NSLog(@"this is %d",firstweekday);
    
    
    [self printfCalender:days firstday:firstweekday month:month year:year];
}

//获得某一个月的总天数
-(int)getdaysofmonth:(int)year months:(int)month
{
    int result;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            result = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            result = 30;
            break;
        case 2:
        {
            if((year%4==0&&year%100!=0)||(year%400==0))
            {
                result = 29;
            }else
            {
                result = 28;
            }
            break;
        }
        default:
            break;
    }
    
    return result;
}
//获得某一个月的第一天的weekday
-(int)getfirstweekdayofmonth:(int)year months:(int)month
{
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:month];
    [components setYear:year];
    NSCalendar * calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [calender dateFromComponents:components];
    NSDateComponents * weekdays = [calender components:NSWeekdayCalendarUnit fromDate:date];
    int weeks = (int)[weekdays weekday];
    return weeks-1;
}

//输出月历
-(void)printfCalender:(int)days firstday:(int)firstday month:(int)month  year:(int)year
{
    int i;
    NSMutableString *resultstring = [[NSMutableString alloc] init];
    [resultstring appendString:@"\n"];
    NSString * monthstring;
    switch (month) {
        case 1:
            monthstring =@"        一 月";
            break;
        case 2:
             monthstring =@"       二 月";
            break;
        case 3:
            monthstring =@"        三 月";
            break;
        case 4:
            monthstring =@"        四 月";
            break;
        case 5:
            monthstring =@"        五 月";
            break;
        case 6:
            monthstring =@"        六 月";
            break;
        case 7:
            monthstring =@"        七 月";
            break;
        case 8:
            monthstring =@"        八 月";
            break;
        case 9:
            monthstring =@"        九 月";
            break;
        case 10:
            monthstring =@"        十 月";
            break;
        case 11:
            monthstring =@"        十一 月";
            break;
        case 12:
            monthstring =@"        十二 月";
            break;
        default:
            break;
    }
    [resultstring appendString:monthstring];
    NSString * yearsting = [NSString stringWithFormat:@"   %d\n",year];
    [resultstring appendString:yearsting];
    [resultstring appendString:@"日  一  二  三  四  五  六\n"];
    NSString *spacestring = @" ";
    
    bool isseven = true;
    
    if (firstday!=7)
    {
        isseven = false;
        for(i=1;i<=(4*firstday);i++)
        {
            [resultstring appendString:spacestring];
        }
    }
    int counts = firstday;
    if (isseven) {
        counts =0;
    }
    for(i=1;i<=days;i++)
    {

        if(counts%6==0&&counts)
        {
            NSString * str = [NSString stringWithFormat:@"%2d\n",i];
            [resultstring appendString:str];
            counts = 0;
        }else
        {
            NSString * str = [NSString stringWithFormat:@"%2d  ",i];
            [resultstring appendString:str];
            counts++;
        }
    }
    NSLog(@"");
    NSLog(@"%@",resultstring);
    resultstring = nil;
}

@end
