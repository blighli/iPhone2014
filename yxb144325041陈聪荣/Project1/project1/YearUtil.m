//
//  Year.m
//  project1
//
//  Created by 陈聪荣 on 14-10-9.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "YearUtil.h"
#import "MonthUtil.h"

@implementation YearUtil

- (id)init{
    self = [super init];
    return self;
}

-(void) cal{
    _monthArray = [NSMutableArray new];
    for(int i=1 ; i<=12 ; i++){
        MonthUtil *util = [MonthUtil new];
        util.year = _year;
        util.month = i;
        [util cal];
        [_monthArray addObject:util];
    }
}

- (void)print{
    //打印年份
    printf("                              ");
    printf("%4d",(int)_year);
    printf("                              ");
    printf("\n\n");
    NSArray *monthChs = @[@"一月", @"二月" , @"三月" , @"四月" , @"五月" , @"六月" , @"七月" , @"八月" , @"九月" , @"十月" , @"十一月" , @"十二月"];
    //日历按maxMonthInOneRow分的行数
    int rowStartIndex = 0;
    int rowEndIndex = (int)_monthArray.count/_rowMonthCount;
    if(_monthArray.count % _rowMonthCount != 0){
        rowEndIndex ++;
    }
    for(int i=rowStartIndex; i<rowEndIndex ; i++){
        int columnStartIndex = i*_rowMonthCount;
        int columnEndIndex = columnStartIndex + _rowMonthCount<(int)_monthArray.count?columnStartIndex+_rowMonthCount:(int)_monthArray.count;
        //打印月份
        for(int j=columnStartIndex; j<columnEndIndex ;j++){
            NSString *monthName = [monthChs objectAtIndex:j];
            printf("       ");
            if ([monthName length]==2) {
                printf(" ");
            }
            printf("%s",[monthName UTF8String]);
            printf("       ");
            if ([monthName length]==2) {
                printf(" ");
            }
            if(j<columnEndIndex-1){
                printf("  ");
            }else{
                printf("\n");
            }
        }
        //打印星期
        for (NSInteger j=columnStartIndex; j<columnEndIndex; j++) {
            printf("日 一 二 三 四 五 六   ");
            if(j<columnEndIndex-1){
                printf("  ");
            }else{
                printf("\n");
            }
        }
        NSInteger maxWeekCountInOneRow = 0;
        //maxWeekCountInOneRow为每行所有月的最大星期数
        for (int j=columnStartIndex; j<columnEndIndex; j++) {
            MonthUtil *monthUtil = [_monthArray objectAtIndex:j];
            NSMutableArray *array = monthUtil.weekdayArray;
            int firstDayWeekday = [[array objectAtIndex:0] intValue];
            int dayCount = (int)(array.count);
            int firstWeekDayCount = 7-firstDayWeekday;
            int weekCount = 1+(dayCount-firstWeekDayCount)/7;
            if ((dayCount-firstWeekDayCount)%7 != 0) {
                weekCount++;
            }
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
                MonthUtil *monthUtil = [_monthArray objectAtIndex:k];
                NSMutableArray *monthArray = monthUtil.weekdayArray;
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
