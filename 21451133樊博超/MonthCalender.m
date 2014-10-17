//
//  MonthCalender.m
//  homework1.0
//
//  Created by 樊博超 on 14-10-12.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MonthCalender.h"

@implementation MonthCalender

-(id) init{
    self = [super init];
    return self;
}

/**
 *判断是否为闰年
 */
+(BOOL)isleapyear:(NSInteger)year{
    if(year%4==0)
    {
        if(year%100!=0)
            return true;
        else if(year%100==0&&year%400==0)
            return true;
        else
            return false;
    }
    else
        return false;
}

/**
 *绘出单月的月历
 */
-(void) drawbyMonth:(NSInteger)month andyear:(NSInteger)year{
    NSString *monthStr;
    NSInteger monthday;
    switch (month) {
        case 1:
            monthStr = @"一月";
            monthday = 31;
            break;
        case 2:
            monthStr = @"二月";
            monthday = [MonthCalender isleapyear:year] ? 29 : 28;
            break;
        case 3:
            monthStr = @"三月";
            monthday = 31;
            break;
        case 4:
            monthStr = @"四月";
            monthday = 30;
            break;
        case 5:
            monthStr = @"五月";
            monthday = 31;
            break;
        case 6:
            monthStr = @"六月";
            monthday = 30;
            break;
        case 7:
            monthStr = @"七月";
            monthday = 31;
            break;
        case 8:
            monthStr = @"八月";
            monthday = 31;
            break;
        case 9:
            monthStr = @"九月";
            monthday = 30;
            break;
        case 10:
            monthStr = @"十月";
            monthday = 31;
            break;
        case 11:
            monthStr = @"十一月";
            monthday = 30;
            break;
        default:
            monthStr = @"十二月";
            monthday = 31;
            break;
    }
    printf("    %s %ld\n", [monthStr UTF8String], year);
    printf("日 一 二 三 四 五 六\n");
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    long weekday = [weekdayComponents weekday];
    weekday--;
    for (int i = 0; i < weekday; i++) {
        printf("   ");
    }
    for (int i = 1; i <= monthday; i++) {
        if((weekday + i) % 7 == 1){
            printf("\n");
        }
        printf("%2d ", i);
    }
    printf("\n");
}

/**
 *得到本日是周几
 */
+(long)getWeekdayByYear:(NSInteger)year Month:(NSInteger)month andday:(NSInteger)day{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:date];
    long weekday = [weekdayComponents weekday];
    return weekday;
}

/**
 *得到本月有多少天
 */
+(long)getMonthdayByYear:(NSInteger)year andMonth:(NSInteger)month{
    NSString *monthStr;
    NSInteger monthday;
    switch (month) {
        case 1:
            monthStr = @"一月";
            monthday = 31;
            break;
        case 2:
            monthStr = @"二月";
            monthday = [MonthCalender isleapyear:year] ? 29 : 28;
            break;
        case 3:
            monthStr = @"三月";
            monthday = 31;
            break;
        case 4:
            monthStr = @"四月";
            monthday = 30;
            break;
        case 5:
            monthStr = @"五月";
            monthday = 31;
            break;
        case 6:
            monthStr = @"六月";
            monthday = 30;
            break;
        case 7:
            monthStr = @"七月";
            monthday = 31;
            break;
        case 8:
            monthStr = @"八月";
            monthday = 31;
            break;
        case 9:
            monthStr = @"九月";
            monthday = 30;
            break;
        case 10:
            monthStr = @"十月";
            monthday = 31;
            break;
        case 11:
            monthStr = @"十一月";
            monthday = 30;
            break;
        default:
            monthStr = @"十二月";
            monthday = 31;
            break;
    }
    return monthday;
}

/**
 *根据组号返回月份字符串
 */
+(NSString *)monthString:(NSInteger)n{
    NSString * out=[[NSString alloc] init];
    switch (n) {
        case 0:
            out=@"        一月                  二月                  三月\n";
            break;
        case 1:
            out=@"        四月                  五月                  六月\n";
            break;
        case 2:
            out=@"        七月                  八月                  九月\n";
            break;
        case 3:
            out=@"        十月                  十一月                十二月\n";
            break;
        default:
            break;
    }
    return out;
}

/**
 *绘出全年月历
 */
-(void)drawbyYear:(NSInteger)year{
    int timearray [30][30]={0};
    long weekday = [MonthCalender getWeekdayByYear:year Month:1 andday:1];
    int basex = 0;
    int basey = 0;
    int xpos = 0;
    long ypos = weekday - 1;
    for (int i = 1; i <=12; i++) {
        xpos = 0;
        basex = (i - 1) / 3;
        basey = (i - 1) % 3;
        for (int j = 1; j <= [MonthCalender getMonthdayByYear:year andMonth:i]; j++) {
            timearray[basex * 6 + xpos][basey * 7 + ypos++] = j;
            if (ypos > 6) {
                ++xpos;
                ypos = 0;
            }
        }
    }
    NSMutableString *output = [[NSMutableString alloc] init];
    [output appendString: @"                              "];
    [output appendString: [NSString stringWithFormat:@"%ld",year]];
    [output appendString: @"\n\n"];
    for (int k = 0; k < 4; k++) {
        [output appendString:[MonthCalender monthString:k]];
        [output appendString: @"日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n"];
        for (int i = k * 6; i < k * 6 + 6; i++) {
            for (int j = 0; j < 21; j++) {
                if (timearray[i][j] == 0) {
                    [output appendString: @"   "];
                }else{
                    [output appendString:[NSString stringWithFormat:@"%2d ",timearray[i][j]]];
                }
                if (j % 7 == 6) {
                    [output appendString: @" "];
                }
            }
            [output appendString:@"\n"];
        }
    }
    printf("%s",[output UTF8String]);
}



@end