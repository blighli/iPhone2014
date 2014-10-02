//
//  PQCal.m
//  Project1-Cal
//
//  Created by 黄盼青 on 14-10-1.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "PQCal.h"

@implementation PQCal


//根据年月打印出日历
+(NSString *)printCal:(NSUInteger)months andYears:(NSUInteger)years
{
    NSUInteger _months;
    NSUInteger _years;
    
    //创建缺省日期
    NSDate *defaultDate=[NSDate date];
    NSCalendar *gregorianCalendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger calendarUnitFlag=(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit);
    NSDateComponents *defaultComp=[gregorianCalendar components:calendarUnitFlag fromDate:defaultDate];
    
    NSArray *chineseMonth=[[NSArray alloc]initWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二", nil];
    

    //判断输入的月份是否合法
    if(months>0 && months<=12)
    {
        _months=months;
    }else
    {
        //使用当前月份
        _months=[defaultComp month];
    }
    //判断输入的年份是否合法
    if(years>0)
    {
        _years=years;
    }else
    {
        //使用当前年份
        _years=[defaultComp year];
    }
    
    //创建新的NSDateComponents用于日历计算
    NSDateComponents *tempComp=[[NSDateComponents alloc]init];
    [tempComp setMonth:_months];
    [tempComp setYear:_years];
    [tempComp setDay:1];
    NSDate *tempDate=[gregorianCalendar dateFromComponents:tempComp];
    NSDateComponents *userComp=[gregorianCalendar components:calendarUnitFlag fromDate:tempDate];
    
    NSString *currentChineseMonth=[chineseMonth objectAtIndex:[userComp month]];
    
    NSMutableString *printResult=[NSMutableString stringWithFormat:@"\r\n         %@月  %ld",currentChineseMonth,[userComp year]];
    [printResult appendString:@"\r\n  日  一  二  三  四  五  六  "];
    
    NSLog(@"%@",printResult);
    
    


    
    return @"haha";
    
}

@end
