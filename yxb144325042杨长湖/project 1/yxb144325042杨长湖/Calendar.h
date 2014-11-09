//
//  Calendar.h
//  yxb144325042杨长湖
//
//  Created by 杨长湖 on 14-10-10.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#ifndef yxb144325042____Calendar_h
#define yxb144325042____Calendar_h

#endif

@interface Calendar : NSObject
{
    //int calendarDayTotal;     //一个月天数
    int calendar[6][7];     //一个月存放数组
}

- (void) buildCalendar:(int)year andMonth:(int)month;
- (void) showCalendar;
- (int) weekDayOfMonth:(int)year andMonth:(int)month;
- (int) totalDayOfMonth:(int)year andMonth:(int)month;
- (int) getCalendarRC:(int)r andc:(int)c;

@end