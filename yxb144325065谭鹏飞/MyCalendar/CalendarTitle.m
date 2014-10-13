//
//  CalendarTitle.m
//  MyCalendar
//
//  Created by cstlab on 14-10-12.
//  Copyright (c) 2014年 CSTTan. All rights reserved.
//

#import "CalendarTitle.h"

@interface CalendarTitle()
@property (strong, nonatomic) NSArray *monthName;

@end
@implementation CalendarTitle

-(NSArray *)monthName{
    if (!_monthName) {
        _monthName = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月",];
    }
    return _monthName;
}
-(CalendarTitle *)initWithMonth:(NSUInteger)month WithYear:(NSUInteger)year{
    _month = month;
    _year = year;
    return self;
}

-(void) showTitle{
    for (int i = 0; i <= 5; i++) {
        printf(" ");
    }
    printf("%s   %ld\n",[self.monthName[self.month-1] UTF8String], self.year);
}
@end
