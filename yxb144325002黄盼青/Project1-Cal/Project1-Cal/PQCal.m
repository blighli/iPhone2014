//
//  PQCal.m
//  Project1-Cal
//
//  Created by 黄盼青 on 14-10-1.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "PQCal.h"

@implementation PQCal

/**
* 初始化一整年日历
*/
- (id)initWithYear:(NSUInteger)years {
    self = [super init];
    if (self) {
        //计算一整年12个月的日历
        self->OneYearCalendar = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 12; i++) {
            [self->OneYearCalendar addObject:[self calculateCalendar:i andYears:years]];
        }
    }
    return self;
}


/***
* 计算某年某月日历，并返回每行日历数组
*/
- (NSMutableArray *)calculateCalendar:(NSUInteger)months andYears:(NSUInteger)years {
    NSMutableArray *monthCalendar = [NSMutableArray new];
    //检验年月格式是否符合
    if (months > 0 && months <= 12 && years > 0 && years <= 9999) {
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *defaultDateComp = [[NSDateComponents alloc] init];
        [defaultDateComp setYear:years];
        [defaultDateComp setMonth:months];
        [defaultDateComp setDay:1];
        NSDate *defaultDate = [gregorian dateFromComponents:defaultDateComp];

        NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:defaultDate];
        //该月总天数
        NSUInteger totalDays = range.length;
        //该月1号为星期几
        NSUInteger firstDayWeekday = [[gregorian components:NSWeekdayCalendarUnit fromDate:defaultDate] weekday];

        NSUInteger currentDays = 1;

        for (NSUInteger i = 0; i < 6; i++) {
            if (i == 0) {
                NSMutableArray *rowMonthCalendarArray = [NSMutableArray new];
                //首行天数
                NSUInteger firstRowDaysCount = 7 - firstDayWeekday + 1;
                //首行空位置数
                NSUInteger firstRowSpaceCount = firstDayWeekday - 1;
                for (int firstRowSpace = 0; firstRowSpace < firstRowSpaceCount; firstRowSpace++) {
                    [rowMonthCalendarArray addObject:@"  "];
                }
                for (int firstRowDays = 0; firstRowDays < firstRowDaysCount; firstRowDays++) {
                    if (currentDays <= totalDays) {
                        [rowMonthCalendarArray addObject:currentDays < 10 ? [NSString stringWithFormat:@" %ld", currentDays] : [NSString stringWithFormat:@"%ld", currentDays]];
                        currentDays++;
                    }
                }
                [monthCalendar addObject:rowMonthCalendarArray];
            } else {
                NSMutableArray *rowMonthCalendarArray = [NSMutableArray new];
                for (int otherRowDays = 0; otherRowDays < 7; otherRowDays++) {
                    if (currentDays <= totalDays) {
                        [rowMonthCalendarArray addObject:currentDays < 10 ? [NSString stringWithFormat:@" %ld", currentDays] : [NSString stringWithFormat:@"%ld", currentDays]];
                        currentDays++;
                    }
                }
                [monthCalendar addObject:rowMonthCalendarArray];
            }
        }


    } else {
        @throw [NSException exceptionWithName:@"格式错误" reason:@"年或月格式错误" userInfo:nil];
    }
    return monthCalendar;
}

/***
* 打印某月日历
*/
- (void)printCalculateByMonth:(NSUInteger)months {
    if (months > 0 && months <= 12) {
        printf("日 一 二 三 四 五 六\r\n");
        NSArray *currentMonthArray = self->OneYearCalendar;

        NSArray *rowMonthArray = [currentMonthArray objectAtIndex:months];
        for (int j = 0; j < rowMonthArray.count; j++) {
            NSArray *daysArray = [rowMonthArray objectAtIndex:j];
            for (int k = 0; k < daysArray.count; k++) {
                printf("%s ", [[daysArray objectAtIndex:k] UTF8String]);
            }
            printf("\r\n");
        }


    } else {
        @throw [NSException exceptionWithName:@"参数格式错误" reason:@"月份必须是1-12之间的整数" userInfo:nil];
    }
}

@end
