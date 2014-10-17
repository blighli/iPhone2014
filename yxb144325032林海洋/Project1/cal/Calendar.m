//
//  MyCalendar.m
//  sunny
//
//  Created by sunny on 14-10-17.
//  Copyright (c) 2014年 sunny. All rights reserved.
//


#import "Calendar.h"

static NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
                             NSDayCalendarUnit | NSWeekdayCalendarUnit;

@implementation Calendar

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSCalendar *gre = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents * today = [gre components:unitFlags fromDate:[NSDate date]];
        NSDateComponents *newComp = [[NSDateComponents alloc] init];
        newComp.year = today.year;
        newComp.month = today.month;
        NSDate *date = [gre dateFromComponents:newComp];
        self.components = [gre components:unitFlags fromDate:date];
    }
    return self;
}

- (instancetype)initWithYear:(int) year {
    self = [super init];
    if (self) {
            NSCalendar *gre = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *newComp = [[NSDateComponents alloc] init];
            newComp.year = year;
            newComp.month = 1;
            NSDate *date  = [gre dateFromComponents:newComp];
            self.components = [gre components:unitFlags fromDate:date];
    }
    return self;
}

- (instancetype)initWithYear:(int)year andMonth:(int)month {
    self = [super init];
    if (self) {
        NSCalendar *gre = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *newComp = [[NSDateComponents alloc] init];
        newComp.year = year;
        newComp.month = month;
        NSDate *date  = [gre dateFromComponents:newComp];
        self.components = [gre components:unitFlags fromDate:date];
    }
    return self;
}

- (instancetype)initWithMonth:(int)month {
    self = [super init];
    if (self) {
        NSCalendar *gre = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents * today = [gre components:unitFlags fromDate:[NSDate date]];
        NSDateComponents *newComp = [[NSDateComponents alloc] init];
        newComp.year = today.year;
        newComp.month = month;
        NSDate *date  = [gre dateFromComponents:newComp];
        self.components = [gre components:unitFlags fromDate:date];
    }
    return self;
}


+ (void)setMonthWithComponents:(NSDateComponents *)comp
                               into:(NSArray *)ss
                            hasYear:(BOOL)hasYear {
    NSRange range;
    range.length = 1;
    range.location = comp.month;
    NSString *month;
    if (range.location <= 10) {
        month = [@"0一二三四五六七八九十" substringWithRange:range];
    } else if (range.location == 11) {
        month = @"十一";
    } else {
        month = @"十二";
    }
    month = [NSString stringWithFormat:@"%@月", month];
    
    
    NSString *title = month;
    if (hasYear) {
        NSString *year = [[NSNumber numberWithInteger:comp.year] stringValue];
        title = [NSString stringWithFormat:@"%@ %@", month, year];
    }
    
    int width =(int)month.length + (int)title.length;
    int before = (20 -  width) / 2;
    int after = 20 - before - width;
    while (before--) [ss[0] appendString:@" "];
    [ss[0] appendString:title];
    while (after--) [ss[0] appendString:@" "];
    
    [ss[1] appendString:@"日 一 二 三 四 五 六"];
    
    int days = 0;
    if(comp.month == 1 || comp.month == 3 || comp.month == 5 || comp.month == 7 || comp.month == 8
       ||comp.month == 10|| comp.month == 12)
        days = 31;
    else if (comp.month == 4 || comp.month == 6 || comp.month == 9 || comp.month == 11)
        days = 30;
    else
        if ((!(comp.year % 4) && (comp.year % 100)) || !(comp.year % 400)) {
            days = 29;
        } else {
            days = 28;
        }
    int d = 1;
    int weekday = (int) comp.weekday;
    for (int line = 2; line < 8; line++) {
        for (int i = 0; i < 7; i++) {
            if (--weekday > 0 || d > days) [ss[line] appendString:@"  "];
            else [ss[line] appendFormat:@"%2d", d++];
            if (i < 6) [ss[line] appendString:@" "];
        }
    }
}

- (void)printMonth {
    NSMutableArray *ss = [NSMutableArray arrayWithCapacity:8];
    for (int i = 0; i < 8; i++) {
        [ss addObject:[NSMutableString stringWithCapacity:100]];
    }
    [[self class] setMonthWithComponents:self.components into:ss hasYear:YES];
    for (NSString *s in ss) {
        printf("%s\n", [s cStringUsingEncoding:NSUTF8StringEncoding]);
    }
}

- (void)printYear {
    NSString *year = [[NSNumber numberWithInteger:self.components.year] stringValue];
    int before = (64 -  (int)year.length) / 2;
    while (before--) printf(" ");
    printf("%s\n\n", [year cStringUsingEncoding:NSUTF8StringEncoding]);
    
    int y = (int) self.components.year;
    for (int row = 0; row < 4; row++) {
        NSMutableArray *ss = [NSMutableArray arrayWithCapacity:8];
        for (int i = 0; i < 8; i++) {
            [ss addObject:[NSMutableString stringWithCapacity:100]];
        }
        for (int col = 1; col <= 3; col++) {
    
            NSDateComponents *newComp = [[NSDateComponents alloc] init];
            newComp.year = y;
            newComp.month = row * 3 + col;
            NSCalendar *gre = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDate *date = [gre dateFromComponents:newComp];
            self.components = [gre components:unitFlags fromDate:date];
            [[self class] setMonthWithComponents:self.components into:ss hasYear:NO];
            if (col < 3) {
                for (NSMutableString *s in ss) [s appendString:@"  "];
            }
        }
        for (NSString *s in ss) {
            printf("%s\n", [s cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }
}


@end	
