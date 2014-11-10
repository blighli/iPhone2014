//
//  GCalendar.h
//  GCalendar
//
//  Created by YilinGui on 14-10-9.
//  Copyright (c) 2014年 YilinGui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCalendar : NSObject

+ (void)printCalendarOfMonth:(NSInteger)_month inYear:(NSInteger)_year;

+ (void)printCalendarOfYear:(NSInteger)_year;

@end
