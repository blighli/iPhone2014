//
//  CalendarUtils.m
//  Project1
//
//  Created by xsdlr on 14-10-2.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "CalendarUtils.h"

@implementation CalendarUtils
- (id)init {
    self = [super init];
    if (self) {
        self->calender = [[NSCalendar alloc]
                          initWithCalendarIdentifier: NSGregorianCalendar];
        self->array = [NSMutableArray new];
        _maxMonthInOneRow = 1;
        _isShowYearInFirstLine = NO;
    }
    return self;
}
- (void)calcCalendarWithYear:(NSInteger)year andMonth:(NSInteger)month {
    NSDateComponents *components = [NSDateComponents new];
    [components setDay:1];
    [components setMonth:month];
    [components setYear:year];
    BOOL isBefore1752 = false;
    //获得指定日期实例
    NSDate *date = [calender dateFromComponents:components];
    NSRange range = [calender rangeOfUnit:NSDayCalendarUnit inUnit: NSMonthCalendarUnit forDate:date];
    //当月的天数
    NSInteger dayCount = (int)range.length;
    //当月第一天星期几
    NSInteger firstDayWeekday = [[calender components:NSWeekdayCalendarUnit fromDate:date]weekday];
    //存储一个月的信息
    NSMutableArray *monthArray = [NSMutableArray new];
    for(int i=0;i<dayCount;i++){
        //确定该日为星期几
        NSInteger weekday = -1;
        //使用格里高利历之前
        if ((year<1752) || (year==1752&&month<9) || (year==1752&&month==9&&i<13)) {
            isBefore1752 = true;
            weekday = (firstDayWeekday+i+3)%7;
            //世界上不存在的11天
            if (year==1752 && month==9 && i<13 && i>1) {
                weekday = -1;
            }
        } else {
          weekday = (firstDayWeekday+i-1)%7;
        }
        [monthArray addObject:[NSNumber numberWithInteger: weekday]];
    }
    //使用格里高利历前要修正一月第一天是周几
    if (isBefore1752) {
        if(firstDayWeekday>3){
            firstDayWeekday = (firstDayWeekday+4)%7;
        } else {
            firstDayWeekday = firstDayWeekday+4;
        }
    }
    NSInteger firstWeekDayCount = 8-firstDayWeekday;
    NSInteger weekCount = 1+(dayCount-firstWeekDayCount)/7;
    if ((dayCount-firstWeekDayCount)%7 != 0) {
        weekCount++;
    }
    
    NSDictionary *dictionary = @{@"weekCount":[NSNumber numberWithInteger:weekCount],@"array":monthArray,@"year":[NSNumber numberWithInteger:year],@"month":[NSNumber numberWithInteger:month]};
    [array addObject:dictionary];
    
}
- (void)printCalendar {
    //日历按maxMonthInOneRow分的行数
    NSInteger rowStartIndex = 0;
    NSInteger rowEndIndex = array.count/_maxMonthInOneRow;
    if(array.count % _maxMonthInOneRow != 0){
        rowEndIndex ++;
    }
    if (_isShowYearInFirstLine == YES) {
        for (NSInteger i=0; i<(22*_maxMonthInOneRow-5)/2; i++) {
            printf(" ");
        }
        printf("%d\n\n",[[[array objectAtIndex:0] objectForKey:@"year"] intValue]);
    }
    
    for (NSInteger i=rowStartIndex; i<rowEndIndex; i++) {
        //该行月起始上标
        NSInteger columnStartIndex = i*_maxMonthInOneRow;
        //该行月结束下标
        NSInteger columnEndIndex = columnStartIndex+_maxMonthInOneRow<array.count?columnStartIndex+_maxMonthInOneRow:array.count;
        for (NSInteger j=columnStartIndex; j<columnEndIndex; j++) {
            if (_isShowYearInFirstLine == YES) {
                printf("        ");
                printf("%2d月",[[[array objectAtIndex:j] objectForKey:@"month"] intValue]);
                printf("        ");
            }else{
                printf("     ");
                printf("%2d月 %4d",[[[array objectAtIndex:j] objectForKey:@"month"] intValue],[[[array objectAtIndex:j] objectForKey:@"year"] intValue]);
                printf("      ");
            }
            if(j<columnEndIndex-1){
                printf("  ");
            }else{
                printf("\n");
            }
        }
        //第二行的中文
        for (NSInteger j=columnStartIndex; j<columnEndIndex; j++) {
            printf("日 一 二 三 四 五 六");
            if(j<columnEndIndex-1){
                printf("  ");
            }else{
                printf("\n");
            }
        }
        NSInteger maxWeekCountInOneRow = 0;
        //maxWeekCountInOneRow为每行所有月的最大星期数
        for (NSInteger j=columnStartIndex; j<columnEndIndex; j++) {
            NSInteger weekCount = [[[array objectAtIndex:j] objectForKey:@"weekCount"] integerValue];
            if(weekCount>maxWeekCountInOneRow) {
                maxWeekCountInOneRow = weekCount;
            }
        }
        NSInteger _dayPeek = 0;//修正一周开始的日子
        NSInteger peekClumnNo = -1;//在同一行的第几个月需要dayPeek修正
        for (NSInteger j=0; j<maxWeekCountInOneRow; j++) {
            
            for (NSInteger k=columnStartIndex; k<columnEndIndex; k++) {
                NSInteger dayPeek = 0;
                if (k==peekClumnNo) {
                    dayPeek = _dayPeek;
                }
                NSMutableArray *monthArray = [[array objectAtIndex:k] objectForKey:@"array"];
                NSInteger firstDayWeekday = [[monthArray objectAtIndex:0] integerValue];
                NSInteger monthRowStartIndex = 0;
                NSInteger monthRowEndIndex = (7*(j+1)-firstDayWeekday+dayPeek)<monthArray.count?(7*(j+1)-firstDayWeekday+dayPeek):monthArray.count;
                if (j==0) {
                    //补齐日历每月第一行数字的空格
                    for(NSInteger l=0; l<firstDayWeekday; l++) {
                        printf("   ");
                    }
                }else{
                    monthRowStartIndex = 7*j-firstDayWeekday+dayPeek;
                }
                //代表同行的月有更多行数，但该月没有，需要补齐一行空格
                if (monthRowStartIndex >= monthRowEndIndex) {
                    for (NSInteger k=0; k<21; k++) {
                        printf(" ");
                    }
                }
                //每次遍历为月的一周
                for(NSInteger l=monthRowStartIndex; l<monthRowEndIndex; l++) {
                    NSInteger weekday = [[monthArray objectAtIndex:l] intValue];
                    if (weekday>=0) {
                        printf("%2d ",(int)l+1);
                    } else {
                        peekClumnNo = k;
                        _dayPeek ++;
                        monthRowEndIndex ++;
                    }
                }
                //一月每行最后一天
                int lastWeekDay = [[monthArray objectAtIndex:monthRowEndIndex-1] intValue];
                //该月这周还有天数
                if (monthRowStartIndex < monthRowEndIndex) {
                    for(NSInteger l=0; l<6-lastWeekDay; l++) {
                        //补齐一行最后一天后面的空格
                        printf("   ");
                    }
                }
                if(k<columnEndIndex-1) {
                    printf(" ");
                }
            }
            printf("\n");
        }
        
    }
}
@end
