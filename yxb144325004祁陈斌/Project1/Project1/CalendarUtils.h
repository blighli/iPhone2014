//
//  CalendarUtils.h
//  Project1
//
//  Created by xsdlr on 14-10-2.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
* @class CalendarUtils
* 日历工具类
*/
@interface CalendarUtils : NSObject {
@private
    NSCalendar *calender;
    NSMutableArray *array;
}
/**
* @property isShowYearInFirstLine
* 绘制日历时是否在首行展示年份
*/
@property BOOL isShowYearInFirstLine;
/**
* @property maxMonthInOneRow
* 日历单行绘制包含的最大月数
*/
@property NSInteger maxMonthInOneRow;

/**
* @method calcCalendarWithYear
* 通过年月计算获得日历
* @param year 年(范围为1-9999)
* @param month 月(范围为1-12)
*/
- (void)calcCalendarWithYear:(NSInteger)year andMonth:(NSInteger)month;

/**
* @method printCalendar
* 输出日历信息
*/
- (void)printCalendar;
@end
