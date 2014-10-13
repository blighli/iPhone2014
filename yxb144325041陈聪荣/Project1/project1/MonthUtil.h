
//
//  Month.h
//  project1
//
//  Created by 陈聪荣 on 14-10-9.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>

//月份工具类
@interface MonthUtil : NSObject{
@private
    NSCalendar *calendar;
}
//存有一个月每一天是星期几的数组
@property (retain) NSMutableArray *weekdayArray;
//年份(范围为1-9999)
@property NSInteger year;
//月份(范围为1-12）
@property NSInteger month;
//通过年月计算获得一个月的日历情况
- (void)cal;
//输出一个月的日历信息
- (void)print;
@end