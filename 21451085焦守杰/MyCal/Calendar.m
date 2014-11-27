//
//  Calendar.m
//  HomeWork1
//
//  Created by 焦守杰 on 14-10-4.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"
@implementation Calendar
char *m[]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
-(void)showMonthCalendar:(int)year : (int)month {
    [self printCalendarWithYear:year andMonth:month];
}

-(void)showYearCalendar:(int)year{
    for(int i=1;i<=12;i++){
        [self showMonthCalendar:year :i];
    }
}
-(void)printCalendarWithYear:(int) year andMonth :(int)month{
    int weekDay=[self weekDay:year:month:1];
    int totalDay=[self totalDayOfMonth:year :month];
  //    NSLog(@"%d %d",weekDay,totalDay);
    printf("        %s  %d\n",m[month-1],year);
    [self printCalendar:weekDay :totalDay];
}
-(int) weekDay:(int) year:(int) month:(int) day{    //获取每个月的一号是星期几
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [weekdayComponents weekday];
    return weekday;
}
-(int)totalDayOfMonth :(int) year:(int) month{  //获取指定月份的天数
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:01];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit: NSMonthCalendarUnit forDate: [cal dateFromComponents:comps]];
    return range.length;
}
-(void)printCalendar:(int)x :(int) totalDay{
    printf("日  一  二  三  四  五  六\n");
    bool first=true;
    int count=0;
    for(int i=1;i<=totalDay;i++){
        if(first){
            for(int j=1;j<x;j++){
                printf("    ");
                count++;
            }
            printf(" %d",i);
            first=false;
        }else{
            if(count==6){
                printf("\n");
                if(i<=9)
                    printf(" ");
                printf("%d",i);
                count=0;
            }else{
                if(i<=9)
                    printf(" ");
                printf("  %d",i);
                count++;
            }
        }
    }
    printf("\n");
}
@end

