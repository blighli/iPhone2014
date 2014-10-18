//
//  CustomCalendar.m
//  CustomCalendar
//
//  Created by 王威 on 14-10-10.
//  Copyright (c) 2014年 com.MySuperCompany. All rights reserved.
//

#import "CustomCalendar.h"

@implementation CustomCalendar

-(id) init
{
    if(self = [super init])
    {
       daysOfMonth = [NSArray arrayWithObjects:@0, @31, @28, @31, @30, @31, @30, @31, @31, @30, @31, @30, @31, nil];
        desOfMonth = [NSArray arrayWithObjects:@"", @"一月", @"二月", @"三 月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月", nil];
        NSDate* date = [NSDate date];
        unsigned flags = NSYearCalendarUnit | NSMonthCalendarUnit;
        NSCalendar* calendar = [NSCalendar calendarWithIdentifier:NSGregorianCalendar];
        comps = [calendar components:flags fromDate:date];
        [comps setDay: 1];
    }
    return (self);
}

-(void) setMonthWithCurrentYear:(long)month
{
    [comps setMonth:month];
}

-(void) setMonth:(long)month Year:(long)year
{
    [comps setMonth:month];
    [comps setYear:year];
}

-(NSInteger) getFirstWeekday
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate* date = [calendar dateFromComponents:comps];
    NSDateComponents* firstDayOfMonthComps = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    return [firstDayOfMonthComps weekday];
}
-(long) getTotalDays
{
    return [daysOfMonth[[comps month] ] integerValue] + (comps.isLeapMonth ? 1 : 0);
}


-(NSString*) description
{
    NSMutableString* result = [NSMutableString stringWithCapacity:100];
    [result appendFormat:@"         %@ %ld\n", desOfMonth[[comps month]], [comps year]];
    [result appendString:@" 日  一  二  三  四  五  六\n"];
    NSInteger weekday = [self getFirstWeekday];
    NSInteger i;
    NSString* space = @" ";
    for (i = 1; i < weekday; i++) {
        for (int j = 0; j <= 3; j++) {
            [result appendString:space];
        }
        
    }
    long totalDays = [self getTotalDays];
    for (int day = 1; day <= totalDays; day++) {
        [result appendFormat:@"%2d  ", day];
        if (i % 7 == 0) {
            [result appendString:@"\n"];
        }
        i++;
    }
    return result;
}

@end
