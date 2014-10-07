//
//  PQCal.h
//  Project1-Cal
//
//  Created by 黄盼青 on 14-10-1.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PQCal : NSObject
{
@private
    NSMutableArray *OneYearCalendar;
    NSArray *chineseMonthName;
    NSUInteger *currentYears;
}


/**
* 初始化一整年日历
*/
- (id)initWithYear:(NSUInteger)years;

/***
* 计算某年某月日历，并返回每行日历数组
*/
-(NSMutableArray *)calculateCalendar:(NSUInteger)months andYears:(NSUInteger)years;

/***
* 打印某月日历
*/
-(void)printCalendarByMonth:(NSUInteger)months;

/***
* 打印一年日历
*/
-(void)printAllYearCalendar;
@end
