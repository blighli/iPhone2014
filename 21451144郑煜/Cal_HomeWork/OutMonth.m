//
//  OutMonth.m
//  Cal_HomeWork
//
//  Created by StarJade on 14-10-11.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import "OutMonth.h"
#import <Foundation/Foundation.h>

@implementation OutMonth

- (instancetype)init
{
    if (self = [super init]) {
        _num = [[NSArray alloc] initWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二", nil];
       
        memset(_monthLine, 0, sizeof(_monthLine));
     
    }
    return self;
}

- (void)clear
{
    memset(_monthLine, 0, sizeof(_monthLine));
    for(int i = 0; i < 8; ++i)
    {
        int j = 0;
        for (j = 0; j < 7*3; ++j) {
            _monthLine[i][j] = ' ';
        }
        
        _monthLine[i][j] = 0;
    }
}

- (void)setMonthAtYear:(int)year Month:(int)month
{
    _year = year;
    _month = month;
    
//    获取该月长度
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *defaultDateComp = [[NSDateComponents alloc] init];
    [defaultDateComp setYear:year];
    [defaultDateComp setMonth:month];
    [defaultDateComp setDay:1];
    NSDate *defaultDate = [gregorian dateFromComponents:defaultDateComp];
    
    NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:defaultDate];
    _daylenth = range.length;
//    确定1号为周几
    
    _weekDay = ((int)[[gregorian components:NSWeekdayCalendarUnit fromDate:defaultDate] weekday] + 7 - 1)%7;
    [self setMonth];
}

- (void)setMonth
{
    sprintf(_monthLine[0],"     %s月 %d      ",[[_num objectAtIndex:(_month - 1)]UTF8String],_year);
    sprintf(_monthLine[1],"日 一 二 三 四 五 六 ");
    
//    先输出月前空格
    int temp = _weekDay % 7;
    int top = 0;
    while (temp--) {
        _monthLine[2][top++] = ' ';
        _monthLine[2][top++] = ' ';
        _monthLine[2][top++] = ' ';
        
    }
//    依次输出天数
    int count = 2;
    for(NSInteger i = 1; i <= _daylenth; ++i){
        
        char temp[4];
        sprintf(temp,"%2d",(int)i);
        _monthLine[count][top++] = temp[0];
        _monthLine[count][top++] = temp[1];
        if (((_weekDay % 7 + i) % 7) == 0) {
            top = 0;
            count++;
        }
        else{
            _monthLine[count][top++] = ' ';
        }
    }
}

- (void)outMonth
{
    for (int i = 0; i < 8; ++i) {
        [self outSingleMonthOf:i];
        printf("\n");
    }
}

- (void)outMonthOf:(int)line
{
    if (line == 0)
    {
         sprintf(_monthLine[0],"       %4s月         ",[[_num objectAtIndex:(_month - 1)]UTF8String]);
    }
    printf("%s",_monthLine[line]);
}
- (void)outSingleMonthOf:(int)line
{
    printf("%s",_monthLine[line]);
}


@end
