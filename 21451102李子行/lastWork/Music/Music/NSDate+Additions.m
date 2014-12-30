//
//  NSDate+Additions.m
//  KHealth
//
//  Created by wang hongxi on 13-10-14.
//  Copyright (c) 2013年 Beijing Dayactive CO. LTD. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate (Additions)
+(NSDateFormatter *)dateFormatter2{
    static NSDateFormatter *dateFormatter2 = nil;
    if (dateFormatter2 == nil) {
        dateFormatter2 = [NSDateFormatter new];
        [dateFormatter2 setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd"]];
        [dateFormatter2 setLocale:[NSLocale currentLocale]];
    }
    return dateFormatter2;
}
-(NSString *)dateString{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:[NSString stringWithFormat:@"yyyy.MM.dd"]];
        [dateFormatter setLocale:[NSLocale currentLocale]];
    }
	return [dateFormatter stringFromDate:self];
}
-(NSString *)dateString2{
	return [[NSDate dateFormatter2] stringFromDate:self];
}
-(NSString *)dateTimeString{
    static NSDateFormatter *dateTimeFormatter = nil;
    if (dateTimeFormatter == nil) {
        dateTimeFormatter = [NSDateFormatter new];
        [dateTimeFormatter setDateFormat:[NSString stringWithFormat:@"yyyy.MM.dd HH:mm"]];
        [dateTimeFormatter setLocale:[NSLocale currentLocale]];
    }
	return [dateTimeFormatter stringFromDate:self];
    
}
-(NSString *)dateTimeString2{
    static NSDateFormatter *dateTimeFormatter2 = nil;
    if (dateTimeFormatter2 == nil) {
        dateTimeFormatter2 = [NSDateFormatter new];
        [dateTimeFormatter2 setDateFormat:[NSString stringWithFormat:@"yyyy-MM-dd HH:mm"]];
        [dateTimeFormatter2 setLocale:[NSLocale currentLocale]];
    }
	return [dateTimeFormatter2 stringFromDate:self];
    
}
-(NSString *)shortDateString{
    static NSDateFormatter *shortDateFormatter = nil;
    if (shortDateFormatter == nil) {
        shortDateFormatter = [NSDateFormatter new];
        [shortDateFormatter setDateFormat:[NSString stringWithFormat:@"MM.dd"]];
        [shortDateFormatter setLocale:[NSLocale currentLocale]];
    }
	return [shortDateFormatter stringFromDate:self];
    
}
-(NSString *)shortDateTimeString{
    static NSDateFormatter *shortDatetimeFormatter = nil;
    if (shortDatetimeFormatter == nil) {
        shortDatetimeFormatter = [NSDateFormatter new];
        [shortDatetimeFormatter setDateFormat:[NSString stringWithFormat:@"M月d日 H:mm"]];
        [shortDatetimeFormatter setLocale:[NSLocale currentLocale]];
    }
	return [shortDatetimeFormatter stringFromDate:self];
    
}
-(NSString *)shortTimeString{
    static NSDateFormatter *shortTimeFormatter = nil;
    if (shortTimeFormatter == nil) {
        shortTimeFormatter = [NSDateFormatter new];
        [shortTimeFormatter setDateFormat:[NSString stringWithFormat:@"HH:mm"]];
        [shortTimeFormatter setLocale:[NSLocale currentLocale]];
    }
	return [shortTimeFormatter stringFromDate:self];
    
}
-(NSString *)longTimeString{
    static NSDateFormatter *longTimeFormatter = nil;
    if (longTimeFormatter == nil) {
        longTimeFormatter = [NSDateFormatter new];
        [longTimeFormatter setDateFormat:[NSString stringWithFormat:@"HH:mm:ss"]];
        [longTimeFormatter setLocale:[NSLocale currentLocale]];
    }
	return [longTimeFormatter stringFromDate:self];
    
}
-(long long)milseconds{
    NSTimeInterval timeInteval = [self timeIntervalSince1970]*1000;
    return [[NSNumber numberWithDouble:timeInteval] longLongValue];
}
+(NSDate *)dateFromYYYYMMDD:(NSString *)dateString{
    return [[self dateFormatter2] dateFromString:dateString];
}
+(NSDate *)dateWithYear:(int)year{
    NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    [components setYear:year];
    return [calendar dateFromComponents:components];

}
+ (NSString *) getTimeDiffString:(NSDate *) temp
{
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];//当前时间
    unsigned int unitFlag = NSDayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *gap = [cal components:unitFlag fromDate:today toDate:temp options:0];//计算时间差
    
    if (ABS([gap day]) > 0)
    {
        return [NSString stringWithFormat:@"%@",[temp shortDateTimeString]];
//        return [NSString stringWithFormat:@"%d天前", ABS([gap day])];
    }else if(ABS([gap hour]) > 0)
    {
        return [NSString stringWithFormat:@"%d小时前", ABS([gap hour])];
    }else{
        if (ABS([gap minute])==0) {
            return [NSString stringWithFormat:@"刚刚"];
        }
        return [NSString stringWithFormat:@"%d分钟前",  ABS([gap minute])];
    }
}
@end
