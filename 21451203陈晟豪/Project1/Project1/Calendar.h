//
//  Calendar.h
//  Project1
//
//  Created by 陈晟豪 on 14-10-11.
//  Copyright (c) 2014年 Apress. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject
{
    //每月有31天和30天的月份数组
    NSArray *thirty_one;
    NSArray *thirty;
    NSArray *month_array;
    NSCalendar *calendar;
    NSDate *now;
    NSDate *date2;
    NSDateComponents *comps;
    NSInteger unitFlags;
    NSDateFormatter *dateFormatter;
    
    //判断月份后展示当月日历
    NSString *thisMonth;
    
    //获取年
    NSInteger year;
    
    //获取月
    NSInteger month;
    
    //获取日
    NSInteger day;
    
    //获取本日是星期几
    NSInteger week;
    
    int month1[6][7];
    int month2[6][7];
    int month3[6][7];

}

- (void)showMonth:(NSInteger)firstDay dayOfMonth:(NSInteger)dom setNumber:(NSInteger)num setMonth:(NSInteger)mon;
- (void)showCalendar:(NSInteger)y setMonth:(NSInteger)m setDay:(NSInteger)d;
- (void)showYearCalendar:(NSInteger)y;
@end
