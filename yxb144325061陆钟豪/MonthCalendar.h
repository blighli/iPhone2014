//
//  MonthCalendar.h
//  mycal
//
//  Created by Hao on 14-10-6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"

@interface MonthCalendar : NSObject
{
    NSDateComponents* _dateCompt;
    NSCalendar* _cal;
    NSString* _content[MONTH_WEEK_LINE];
}

- (id) init;
- (id) initWithMonth:(NSInteger) month;
- (id) initWithYear:(NSInteger) year andMonth:(NSInteger) month;
- (void) calcuate;
- (void) output;
- (NSString*) getContent:(NSInteger) lineNum;
- (NSString*) getMonthHeader;
- (NSString*) getMonthYearHeader;
- (NSInteger) year;
+ (NSString*) getWeekHeader;

@end
