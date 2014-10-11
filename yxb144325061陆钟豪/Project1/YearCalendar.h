//
//  YearCalendar.h
//  mycal
//
//  Created by Hao on 14-10-6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MonthCalendar.h"
#import "Util.h"

@interface YearCalendar : NSObject
{
    MonthCalendar* _monthCal[MAX_MONTH];
    NSInteger _year;
}
- (id) init;
- (id) initWithYear:(NSInteger)year;
- (void) calcuate;
- (NSString*) getHeader;
- (NSString*) getContent:(NSInteger)lineNum;
- (void) output;
@end
