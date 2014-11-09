//
//  MonthUtil.m
//  project1
//
//  Created by 陈聪荣 on 14-10-9.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "MonthUtil.h"

@implementation MonthUtil

- (id)init{
    self = [super init];
    if(self){
        self->calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    return self;
}

- (void)cal{
    //获取这个月的第一天
    NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [matter setTimeZone:timeZone];
    [matter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstDayStr = [NSString stringWithFormat:@"%ld-%ld-%d",_year,_month,1];
    NSDate *firstDay = [matter dateFromString:firstDayStr];
    //这个月的天数
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit: NSMonthCalendarUnit forDate:firstDay];
    NSInteger dayCount = (int)range.length;
    //这个月第一天是星期几
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:firstDay];
    NSInteger firstDayWeekDay = comps.weekday;
    _weekdayArray = [NSMutableArray new];
    //将每天是星期几放入数组中
    for(int i=0 ; i<dayCount ; i++){
        NSInteger weekday = (firstDayWeekDay+i-1)%7;
        [_weekdayArray addObject:[NSNumber numberWithInteger:weekday]];
    }
}

- (void)print{
    NSArray *monthChs = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    NSString *monthstr = [monthChs objectAtIndex:_month-1];
    printf("    ");
    printf("%s %4d",[monthstr UTF8String],(int)_year);
    printf("    ");
    printf("\n");
    printf("日 一 二 三 四 五 六");
    printf("\n");
    int firstDayInteger = (int)[[_weekdayArray objectAtIndex:0] integerValue];
    for(int i=0 ; i<firstDayInteger;i++){
        printf("   ");
    }
    //当前打印的日子的星期
    for(int i=0 ; i<_weekdayArray.count;i++){
        int currentDay = (int)[[_weekdayArray objectAtIndex:i] integerValue];
        printf("%2d ",i+1);
        if(currentDay == 6){
            printf("\n");
        }
    }
    printf("\n");
}

@end
