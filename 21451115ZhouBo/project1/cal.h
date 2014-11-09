//
//  cal.h
//  cal
//
//  Created by zhou on 14-10-9.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

static const char* MonthArray[13] = {"","一月","二月","三月","四月","五月","六月",
    "七月","八月","九月","十月","十一月","十二月"};
// 日历上的一组月份最多占据42个size （计算空格在内）
#define MAXSIZE 6*7

@interface Cal : NSObject

+ (void) showCal:(int) month ofYear: (int)year;
- (int) DayCountOfMonth:(int) month ofYear: (int)year;
- (void) getArrayOfMonth: (int) month ofYear:(int)year theArray:(int [])array;

- (void) getArrayOfYear: (int) year theArray:(int [][MAXSIZE])array;

@end
