//
//  OutMonth.h
//  Cal_HomeWork
//
//  Created by StarJade on 14-10-11.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//
/*功能：设置年月以及一号在一周中的位置，输出月份或者输出月份中的一行,行号从0开始输入*/
#import <Foundation/Foundation.h>

@interface OutMonth : NSObject
{
    int _year;//显示的年份
    int _month;//显示的月份
    
    int _weekDay;/*一号是周几*/

    NSInteger _daylenth;/*该月有几天*/
    NSArray *_num;
    
    char _monthLine[8][50];
}
- (instancetype)init;
- (void)clear;
- (void)setMonthAtYear:(int)year Month:(int)month;
- (void)setMonth;
- (void)outMonth;
- (void)outMonthOf:(int)line;
- (void)outSingleMonthOf:(int)line;


@end
