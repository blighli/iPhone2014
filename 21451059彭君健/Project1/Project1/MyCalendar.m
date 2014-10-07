//
//  MyCalendar.m
//  Project1
//
//  Created by Mz on 14-10-7.
//  Copyright (c) 2014年 Zorro M. All rights reserved.
//

#import "MyCalendar.h"
#import "DateUtil.h"
static NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
                             NSDayCalendarUnit | NSWeekdayCalendarUnit;

@implementation MyCalendar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.components = [DateUtil componentsOfThisMonth];
    }
    return self;
}

- (instancetype)initWithYear:(int) year {
    self = [super init];
    if (self) {
        self.components = [DateUtil componentsFromYear:year andMonth:1];
    }
    return self;
}

- (instancetype)initWithYear:(int)year andMonth:(int)month {
    self = [super init];
    if (self) {
        self.components = [DateUtil componentsFromYear:year andMonth:month];
    }
    return self;
}

- (instancetype)initWithMonth:(int)month {
    self = [super init];
    if (self) {
        self.components = [DateUtil componentsFromMonth:month];
    }
    return self;
}

static const int WIDTH = 20;
static const char *WEEKS = "日 一 二 三 四 五 六";
- (void)printMonth {
    NSRange range;
    range.length = 1;
    range.location = self.components.month;
    NSString *month;
    if (range.location <= 10) {
        month = [@"0一二三四五六七八九十" substringWithRange:range];
    } else if (range.location == 11) {
        month = @"十一";
    } else {
        month = @"十二";
    }
    NSString *year = [[NSNumber numberWithInteger:self.components.year] stringValue];
    int days = [DateUtil daysOfMonth:(int)self.components.month inYear:(int)self.components.year];
    
    // first line
    int before = (WIDTH -  ((int)month.length * 2 + 2 + 1 + (int)year.length)) / 2;
    while (before--) printf(" ");
    printf("%s月 %s\n", [month cStringUsingEncoding:NSUTF8StringEncoding],
           [year cStringUsingEncoding:NSUTF8StringEncoding]);
    
    // second line
    printf("%s\n", WEEKS);
    
    int d = 1;
    int weekday = (int) self.components.weekday;
    int pos = 1;
    while (d <= days) {
        if (--weekday > 0) {
            printf("  ");
        } else {
            printf("%2d", d++);
        }
        if ((pos++) % 7 == 0) {
            printf("\n");
        } else {
            printf(" ");
        }
    }
    printf("\n");
}

- (void)printYear {
    NSString *year = [[NSNumber numberWithInteger:self.components.year] stringValue];
    // first line
    int before = (WIDTH -  (int)year.length) / 2;
    while (before--) printf(" ");
    printf("%s\n\n", [year cStringUsingEncoding:NSUTF8StringEncoding]);
    
    int y = (int) self.components.year;
    for (int i = 1; i <= 12; i++) {
        self.components = [DateUtil componentsFromYear: y andMonth:i];
        [self printMonth];
    }
}
@end	
