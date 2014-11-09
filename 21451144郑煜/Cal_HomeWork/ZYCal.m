//
//  ZYCal.m
//  Cal_HomeWork
//
//  Created by StarJade on 14-10-12.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import "ZYCal.h"

@implementation ZYCal

- (instancetype)init
{
    self = [super init];
    if (self) {
        outMonth = [[OutMonth alloc] init];
        
    //    获取当前年月
        NSDate *today = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponents =
        [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:today];
        _cntYear = (int)[dateComponents year];
        _cntMonth = (int)[dateComponents month];
    }
    return self;
}

//////////////////////////divide//////////////////////////
- (void)input
{
    [self outCurrentMonth];
}

- (void)inputWithOne: (const char *)one
{
    int year = atoi(one);
    if ([self judgeYear:year]) {
        
        [self outYearAt:year];
    }
}
- (void)inputWithOne: (const char *)one Two: (const char *)two
{
    // 输入的是月份
    if (strcmp(one, "-m") == 0)
    {
        int month = atoi(two);
        
        if ([self judgeMonth:month]) {
            
            [self outMonthAt:month];
        }
        
    }else{
        int month = atoi(one);
        int year = atoi(two);
        
        if ([self judgeMonth:month] && [self judgeYear:year]) {
            [self outMonthAtYear:year AtMonth:month];
        }
    }
    
    //输入的时年和月
}

//////////////////////////divide//////////////////////////

- (BOOL)judgeYear:(int)year
{
    if (!(year >0 && year < 10000)) {
        printf("年份的输入超出了范围（支持从1到9999年）！\n");
        return NO;
    }
    
    return YES;
    
}
- (BOOL)judgeMonth:(int)month
{
    if (!(month > 1 && month <=12)) {
        printf("月份超出了范围！\n");
        return NO;
    }
    return YES;
}
//////////////////////////divide//////////////////////////

/*输出当月日历*/
- (void)outCurrentMonth
{

//    输出当前月
    [outMonth setMonthAtYear:_cntYear Month:_cntMonth];
    [outMonth outMonth];
}

- (void)outMonthAtYear:(int)year AtMonth:(int) month
{
//    输出当前月
    [outMonth setMonthAtYear:year Month:month];
    [outMonth outMonth];
}
- (void)outMonthAt:(int)month
{
    [outMonth setMonthAtYear:_cntYear Month:month];
    [outMonth outMonth];
}

- (void)outYearAt:(int)year
{
    printf("                              %d\n\n",year);
    for (int i = 1; i <= 4; ++i) {
        for (int m = 0; m < 8; ++m) {
            for (int j = 1; j<=3; ++j) {
                [outMonth clear];
                [outMonth setMonthAtYear:year Month:((i-1)*3 + j)];
                [outMonth outMonthOf:m];
                printf(" ");
            }
            printf("\n");
        }
    }
    
}
@end
