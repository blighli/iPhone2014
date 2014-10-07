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
        for (NSUInteger i = 1; i <= 12; i++) {
            [self->OneYearCalendar addObject:[self calculateCalendar:i andYears:years]];
        }
        //初始化中文月份名
        self->chineseMonthName= [[NSArray alloc] initWithObjects:@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @"十一", @"十二", nil];
        self->currentYears=years;
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
        NSInteger totalDays = range.length;
        //该月1号为星期几
        NSInteger firstDayWeekday = [[gregorian components:NSWeekdayCalendarUnit fromDate:defaultDate] weekday];

        NSUInteger currentDays = 1;

        for (NSUInteger i = 0; i < 6; i++) {
            if (i == 0) {
                NSMutableString *lineStr=[[NSMutableString alloc] init];
                //首行天数
                int firstRowDaysCount = 7 - firstDayWeekday + 1;
                //首行空位置数
                NSInteger firstRowSpaceCount = firstDayWeekday - 1;
                for (NSUInteger firstRowSpace = 0; firstRowSpace < firstRowSpaceCount; firstRowSpace++) {
                    [lineStr appendString:@"   "];
                }
                for (NSUInteger firstRowDays = 0; firstRowDays < firstRowDaysCount; firstRowDays++) {
                    if (currentDays <= totalDays) {
                        [lineStr appendString:currentDays < 10 ? [NSString stringWithFormat:@" %ld ", currentDays] : [NSString stringWithFormat:@"%ld ", currentDays]];
                        currentDays++;
                    }
                }
                [monthCalendar addObject:lineStr];
            } else {
                NSMutableString *lineStr=[[NSMutableString alloc] init];
                for (int otherRowDays = 0; otherRowDays < 7; otherRowDays++) {
                    if (currentDays <= totalDays) {
                        [lineStr appendString:currentDays < 10 ? [NSString stringWithFormat:@" %ld ", currentDays] : [NSString stringWithFormat:@"%ld ", currentDays]];
                        currentDays++;
                    } else
                    {
                        [lineStr appendString:@"   "];
                    }
                }
                [monthCalendar addObject:lineStr];
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
- (void)printCalendarByMonth:(NSUInteger)months {
    if (months > 0 && months <= 12) {
        printf("     %s月 %ld\r\n", [[self->chineseMonthName objectAtIndex:months - 1] UTF8String],self->currentYears);
        printf("日 一 二 三 四 五 六\r\n");
        NSArray *currentMonthArray = self->OneYearCalendar;

        NSArray *rowMonthArray = [currentMonthArray objectAtIndex:months-1];
        for (int j = 0; j < rowMonthArray.count; j++) {
            printf("%s", [[rowMonthArray objectAtIndex:j] UTF8String]);
            printf("\r\n");
        }


    } else {
        @throw [NSException exceptionWithName:@"参数格式错误" reason:@"月份必须是1-12之间的整数" userInfo:nil];
    }
}

/***
* 打印一年日历
*/
-(void)printAllYearCalendar
{
    int currentMonth=1;
    printf("                             %ld\r\n",self->currentYears);
    //每三个月一行
    for(int monthCountLine=0;monthCountLine<4;monthCountLine++)
    {
        int loopMonth=currentMonth+monthCountLine*3;

        NSArray *firstMonth=[self->OneYearCalendar objectAtIndex:loopMonth-1];
        NSArray *secondMonth=[self->OneYearCalendar objectAtIndex:loopMonth];
        NSArray *thirdMonth=[self->OneYearCalendar objectAtIndex:loopMonth+1];


        for(NSUInteger calLine=0;calLine<=5;calLine++)
        {
            if(calLine==0)
            {
                printf("        %s月                 %s月                  %s月\r\n",
                        [[self->chineseMonthName objectAtIndex:loopMonth - 1] UTF8String]
                        , [[self->chineseMonthName objectAtIndex:loopMonth] UTF8String]
                        , [[self->chineseMonthName objectAtIndex:loopMonth + 1] UTF8String]);
                printf("日 一 二 三 四 五 六   日 一 二 三 四 五 六   日 一 二 三 四 五 六 \r\n");
            }
            NSMutableString *lineStr=[[NSMutableString alloc]init];
            [lineStr appendFormat:@"%@  ",[firstMonth objectAtIndex:calLine]];
            [lineStr appendFormat:@"%@  ",[secondMonth objectAtIndex:calLine]];
            [lineStr appendFormat:@"%@  ",[thirdMonth objectAtIndex:calLine]];
            [lineStr appendString:@"\r\n"];
            printf("%s",[lineStr UTF8String]);
        }
    }
}

@end
