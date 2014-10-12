
//
//  Month.h
//  project1
//
//  Created by 陈聪荣 on 14-10-9.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>
//年度工具类
@interface YearUtil : NSObject{

}
//存有一年12个月MonthUtil的数组
@property (retain) NSMutableArray *monthArray;
//年份
@property NSInteger year;
//一行显示的月份个数
@property int rowMonthCount;
// 通过年月计算获得一个月的日历情况
- (void)cal;
// 输出一个月的日历信息
- (void)print;
@end