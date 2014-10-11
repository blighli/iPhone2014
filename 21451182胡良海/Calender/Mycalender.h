//
//  Mycalender.h
//  Calender
//
//  Created by hu on 14-10-7.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mycalender : NSObject
-(void)showCurrentyearCalender;//输出当年当月的月历
-(void)showCurrentyearCalender:(int)month;//输出当年某一个月的月历
-(void)showyearCalender:(int)year;//输出某一年全部的月历
-(void)showCalener:(int)year months:(int)month;//输出某年某月的月历
-(int)getdaysofmonth:(int)year months:(int)month;//获得某一个月的总天数
-(int)getfirstweekdayofmonth:(int)year months:(int)month;//获得某一个月的第一天是星期几
-(void)printfCalender:(int)days firstday:(int)firstday month:(int)month year:(int)year;//输出月历
@end
