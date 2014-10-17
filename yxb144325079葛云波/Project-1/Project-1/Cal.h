//
//  Cal.h
//  Project-1
//
//  Created by 葛 云波 on 14-10-18.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject
-(void)printCurrentMonthCalendar;//输出当前月的月历
-(void)printCalendarForMonth:(NSInteger)month andYear:(NSInteger)year;//输出某年某月的月历
-(void)printMonthOfCurrentYearCalendar:(NSInteger)month;//输出当年某月的月历
-(void)printYearCalendar:(NSInteger)year;//输出某年全年的月历
@end