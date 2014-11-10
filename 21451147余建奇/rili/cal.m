//
//  cal.m
//  rili
//
//  Created by yjq on 14-10-11.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cal.h"

char *Day={"日 一 二 三 四 五 六"};
char *Month []={"","一月","二月", "三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
int maxSpaceLength=8;
int minSpaceLength=7;

@interface cal()

@property (strong,nonatomic)NSArray *Month;

@end

@implementation cal

-(void)command:(id)string
{
    NSDate *date=[NSDate date];
    NSCalendar *cal=[NSCalendar currentCalendar];
    unsigned int unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
    NSDateComponents *d=[cal components:unitFlags fromDate:date];
    
    int year=(int)[d year];
    int month=(int)[d month];
    int day=(int)[d day];

    int length=[self getYear:year Month:month Day:day];
    int firstWeekDay=[self getWeekday:year Month:month Day:1];
    //NSLog(@"当月长度＝%d,当月第一天是星期%d",length,firstWeekDay);
    printf("     %s %d\n",Month[month],year);
    printf("%s\n",Day);
    [self printfMonthDate:length firstWeekDay:firstWeekDay];
}

-(void)command:(id)string Month:(int)m Year:(int)y
{
    int length=[self getYear:y Month:m Day:1];
    int firstWeekDay=[self getWeekday:y Month:m Day:1];
    printf("     %s %d\n",Month[m],y);
    printf("%s\n",Day);
    [self printfMonthDate:length firstWeekDay:firstWeekDay];
}

-(void)command:(id)string Zhilin:(id)command Month:(int)m
{
    NSDate *date=[NSDate date];
    NSCalendar *cal=[NSCalendar currentCalendar];
    unsigned int unitFlags=NSYearCalendarUnit;
    NSDateComponents *DateComp=[cal components:unitFlags fromDate:date];
    int year=(int)[DateComp year];
    int length=[self getYear:year Month:m Day:1];
    int firstWeekDay=[self getWeekday:year Month:m Day:1];
    printf("     %s %d\n",Month[m],year);
    printf("%s\n",Day);
    [self printfMonthDate:length firstWeekDay:firstWeekDay];
}

-(void)command:(id)string Year:(int)y
{
    printf("                             %d\n\n",y);
    for(int i=0;i<4;i++)
    {
        //输出月份
        for(int m=3*i+1;m<=3*(i+1);m++)
        {
            [self printfMonth:m];
            printf("  ");
        }
        printf("\n");
        //输出一星期日期
        for(int n=0;n<3;n++)
        {
            [self printfWeekDay];
            printf("  ");
        }
        printf("\n");
        //输出日历
        for(int j=1;j<=6;j++)
        {
            for(int m=3*i+1;m<=3*(i+1);m++)
            {
                [self printfMonth:y Month:m Line:j];
                printf(" ");
            }
            printf("\n");
        }
    }
    
}

-(int)getYear:(int)year Month:(int)month Day:(int)day
{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *DateComp = [[NSDateComponents alloc] init];
    [DateComp setYear:year];
    [DateComp setMonth:month];
    [DateComp setDay:day];
    NSDate *Date = [cal dateFromComponents:DateComp];
    
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:Date];
    MonthLength= range.length;
    return (int)MonthLength;
}

-(int)getWeekday:(int)year Month:(int)month Day:(int)day
{
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *DateComp = [[NSDateComponents alloc] init];
    [DateComp setYear:year];
    [DateComp setMonth:month];
    [DateComp setDay:day];
    NSDate *Date = [cal dateFromComponents:DateComp];
    NSDateComponents *weekdayComponents =[cal components:NSWeekdayCalendarUnit fromDate:Date];
    int weekday=(int)[weekdayComponents weekday];
    return weekday;
}
//输出月份
-(void)printfMonth:(int)month
{
    int length;
    if(month<11)
        length=maxSpaceLength;
    else
        length=minSpaceLength;

    for(int i=0;i<length;i++)
    {
        printf(" ");
    }
    printf("%s",Month[month]);
    for(int i=0;i<length;i++)
    {
        printf(" ");
    }
}
//输出一星期日期
-(void)printfWeekDay
{
     printf("%s",Day);
}
//输出单月的月份
-(void)printfMonthDate:(int)length firstWeekDay:(int)day
{
    for (int i=0; i<(day-1)*3; i++) {
        printf(" ");
    }
    for (int i=1; i<length+1; i++) {
        printf("%2d ",i);
        if((day+i-1)%7==0)
            printf("\n");
    }
    printf("\n");
}
//输出某月份某行
-(void)printfMonth:(int)year Month:(int)month Line:(int)line
{
    int length=[self getYear:year Month:month Day:1];
    int firstWeekDay=[self getWeekday:year Month:month Day:1];
    int count=0;//输出的次数，每行count等于7表示输入满了，不达到7则补上空格
    if(line==1)
    {
        for (int i=0; i<(firstWeekDay-1)*3; i++)
        {
            printf(" ");
        }
        count=firstWeekDay-1;
    }
    for (int i=1; i<length+1; i++)
    {
        if((firstWeekDay+i-2)/7==(line-1))
        {
            printf("%2d ",i);
            count++;
        }
    }
    //未输入充足，补空格
    if(count!=7)
    {
        for(int i=0;i<(7-count)*3;i++)
        {
            printf(" ");
        }
    }
    
}

@end


