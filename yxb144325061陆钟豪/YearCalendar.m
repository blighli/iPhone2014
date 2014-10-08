//
//  YearCalendar.m
//  mycal
//
//  Created by Hao on 14-10-6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "YearCalendar.h"
#import "Util.h"

@implementation YearCalendar
- (id) init {
    self = [super init];
    for(NSInteger i = 0; i < MAX_MONTH; ++i) {
        _monthCal[i] = [[MonthCalendar alloc] initWithMonth:i + 1];
    }
    _year = [_monthCal[0] year];
    return self;
}
- (id) initWithYear:(NSInteger)year {
    self = [super init];
    for(NSInteger i = 0; i < MAX_MONTH; ++i) {
        _monthCal[i] = [[MonthCalendar alloc] initWithYear:year andMonth:i + 1];
    }
    _year = [_monthCal[0] year];
    return self;
}

- (void) calcuate {
    for(NSInteger i = 0; i < MAX_MONTH; ++i) {
        [_monthCal[i] calcuate];
    }
}

- (NSString*) getHeader {
    NSString* titleStr = [@"" stringByAppendingFormat:@"%ld", _year];
    return createMidTitle(titleStr, [titleStr length], WIDTH_YEAR_CAL);
}

- (NSString*) getContent:(NSInteger)lineNum {
    NSInteger subLine = (lineNum - 1) % HEIGHT_MONTH_CAL + 1;
    NSInteger offset = (lineNum - 1) / HEIGHT_MONTH_CAL * COL_YEAR_CAL;
    NSInteger m[COL_YEAR_CAL] = {0 + offset, 1 + offset, 2 + offset};
    if(subLine == 1) {
        return [@"" stringByAppendingFormat:@"%@  %@  %@", [_monthCal[m[0]] getMonthHeader]
                , [_monthCal[m[1]] getMonthHeader], [_monthCal[m[2]] getMonthHeader]];
    }
    else if(subLine == 2) {
        NSString* weekHeader = [MonthCalendar getWeekHeader];
        return [@"" stringByAppendingFormat:@"%@  %@  %@", weekHeader, weekHeader, weekHeader];
    }
    else {
        return [@"" stringByAppendingFormat:@"%@  %@  %@", [_monthCal[m[0]] getContent:subLine - 2]
                , [_monthCal[m[1]] getContent:subLine - 2], [_monthCal[m[2]] getContent:subLine - 2]];
    }
}

- (void) output {
    printf("%s\n", [[self getHeader] UTF8String]);
    printf("\n");
    for(NSInteger i = 1; i <= HEIGHT_MONTH_CAL * ROW_YEAR_CAL; ++i) {
        printf("%s\n", [[self getContent:i] UTF8String]);
    }
}
@end
