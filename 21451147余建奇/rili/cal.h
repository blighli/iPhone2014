//
//  cal.h
//  rili
//
//  Created by yjq on 14-10-11.
//  Copyright (c) 2014年 yjq. All rights reserved.
//


#import <Foundation/Foundation.h>

//extern NSArray * const Month;
//extern NSArray * const Day;

@interface cal : NSObject
{
    NSUInteger MonthLength;//当月长度
}

-(void)command:(id)string;//cal指令
-(void)command:(id)string Month:(int) m Year:(int) y;//cal 2014 10指令
-(void)command:(id)string Zhilin:(id) string Month:(int) m;//cal －m 10指令
-(void)command:(id)string Year:(int) y;//cal 2014指令
-(int)getYear:(int)year Month:(int)month Day:(int)day;//得到某年某月的长度
-(int)getWeekday:(int)year Month:(int)month Day:(int)day;//得到某年某月某日是星期几
-(void)printfMonth:(int)month;//输出月份
-(void)printfWeekDay;//输出一星期日期
-(void)printfMonthDate:(int)length firstWeekDay:(int)day;//输出单月的月份
-(void)printfMonth:(int)year Month:(int) month Line:(int)line;//输出某月份某行
@end

