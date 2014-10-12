//
//  LearnCalendar.h
//  DisplayCalendar
//
//  Created by Chencheng on 14-10-7.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LearnCalendar : NSObject
{
@private NSInteger month,year;
}
-(NSInteger) firstWeekday:(NSInteger)month :(NSInteger)year;//计算某年某月第一天是星期几
-(NSInteger) days:(NSInteger)month :(NSInteger)year;//计算某年某月有多少天
-(void)CalendarwithMonth:(NSInteger)month andYear:(NSInteger)year;// 显示指定年月的月历
-(void)CalendarwithYear:(NSInteger)year;//显示指定年每个月的月历
-(void)DisplayCalendar:(NSInteger)month :(NSInteger)year;//输出年月
-(void)outputCalendar:(NSInteger)firstwek:(NSInteger)day;//输出某个月的月历
@end
