//
//  MonthCalendar.m
//  mycal
//
//  Created by Hao on 14-10-6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "MonthCalendar.h"
#import "Util.h"

@implementation MonthCalendar
- (id) init {
    self = [super init];
    _cal = [NSCalendar currentCalendar];
    _dateCompt = [_cal components:(NSYearCalendarUnit|NSMonthCalendarUnit) fromDate:[NSDate new]];
    return self;
}

- (id) initWithMonth:(NSInteger)month {
    self = [self init];
    [_dateCompt setMonth:month];
    return self;
}

- (id) initWithYear:(NSInteger)year andMonth:(NSInteger)month {
    self = [self init];
    [_dateCompt setYear:year];
    [_dateCompt setMonth:month];
    return self;
}

- (void) calcuate {
    NSDate* date = [_cal dateFromComponents:_dateCompt];
    NSRange range = [_cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSInteger weekDayOf1th = [_cal ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date];
    NSInteger l = 0;
    NSInteger w = 0;
    NSString* s = [NSString new];
    for(NSInteger i = range.location - weekDayOf1th + 1; i <= (NSInteger) range.length || l < MONTH_WEEK_LINE; ++i) {
        s = [s stringByAppendingFormat:@"%s", w > 0 ? " " : ""];
        if(i < range.location || i > range.length) {
            s = [s stringByAppendingString:@"  "];
        }
        else {
            s = [s stringByAppendingFormat:@"%2ld", i];
        }
        if(w == 6) {
            if(l >= 0) {
                _content[l] = s;
            }
            s = [NSString new];
            ++l;
        }
        w = (w + 1) % 7;
    }
}

- (void) output {
    printf("%s\n", [[self getMonthYearHeader] UTF8String]);
    printf("%s\n", [[MonthCalendar getWeekHeader] UTF8String]);
    for(NSInteger i = 0; i < MONTH_WEEK_LINE; ++i) {
        if(_content[i] != NULL)
            printf("%s\n", [_content[i] UTF8String]);
    }
}

- (NSString*) getContent:(NSInteger)lineNum {
    return _content[lineNum - 1];
}

static NSString* chineseNumDict[10] = {@"十", @"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九"};

- (NSString*) getMonthHeader {
    NSInteger month = [_dateCompt month];
    NSString* titleStr
    = [@"" stringByAppendingFormat:@"%@%@月"
       , month > 10 ? chineseNumDict[0] : @""
       , chineseNumDict[month % 10]];
    return createMidTitle(titleStr, [titleStr length] * 2, WIDTH_MONTH_CAL);
}

- (NSString*) getMonthYearHeader {
    NSInteger month = [_dateCompt month];
    NSInteger year = [_dateCompt year];
    NSString* monthStr
        = [NSString stringWithFormat:@"%@%@月"
       , month > 10 ? chineseNumDict[0] : @""
           , chineseNumDict[month % 10]];
    NSString* yearStr = [NSString stringWithFormat:@"%ld", year];
    NSString* titleStr = [NSString stringWithFormat:@"%@ %@", monthStr, yearStr];
    NSInteger diplayLenOfTitleStr = [monthStr length] * 2 + 1 + [yearStr length];
    return createMidTitle(titleStr, diplayLenOfTitleStr, WIDTH_MONTH_CAL);
}

- (NSInteger) year {
    return [_dateCompt year];
}

+ (NSString*) getWeekHeader {
    return @"日 一 二 三 四 五 六";
}


@end
