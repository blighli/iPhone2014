//
//  cal.m
//  Cal
//
//  Created by 李丛笑 on 14-10-12.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cal.h"
@implementation Cal

- (int) Firstday: (int)year Month:(int)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [calendar dateFromComponents:comps];
    NSDateComponents *weekdayComponents =[calendar components:NSWeekdayCalendarUnit fromDate:date];
    int firstday = [weekdayComponents weekday];
    return firstday;
}//Firstday

- (int) DaysofMonth:(int) year Month:(int) month
{
    int days[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    if(((year%4 == 0) && (year%100 != 0))||(year%400 == 0))
    {
        days[1] = 29;
    }
    return days[month-1];
}//DaysofMonth

- (NSString *) PrintNameofMonth:(int) month
{
    NSArray *name = @[@" 一月",@" 二月",@" 三月",@" 四月",@" 五月",@" 六月",@" 七月",@" 八月",@" 九月",@" 十月",@"十一月",@"十二月"];
    return [name objectAtIndex:month-1];
}//PrintNameofMonth

- (NSString *) PrintDays
{
    NSString *day = {@"日 一 二 三 四 五 六"};
    return day;
}//PrintDays

- (NSString *) PrintFirstline:(int) firstday
{
    NSMutableString *firstline = [NSMutableString stringWithCapacity:50];
    int i;
    for (i=0; i<(firstday-1)*3; i++) {
        [firstline appendString:@" "];
    }
    for (i=1; i<(9-firstday); i++) {
        [firstline appendString:[NSString stringWithFormat:@"%2d ",i]];
    }
    return firstline;
}//PrintFirstline

- (NSString *) Print:(int) days Firstday:(int) firstday Week:(int) week
{
    int i;
    NSMutableString *line = [NSMutableString stringWithCapacity:50];
    for (i=7*(week-1)+2-firstday; i<7*(week-1)+9-firstday; i++) {
        if(i<10)
            [line appendString:[NSString stringWithFormat:@"%2d ",i]];
        else if(i<=days)
            [line appendString:[NSString stringWithFormat:@"%d ",i]];
        else
            [line appendString:[NSString stringWithFormat:@"   "]];
    }
    return line;
}//Print

@end

