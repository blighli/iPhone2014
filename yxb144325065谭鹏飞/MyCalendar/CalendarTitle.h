//
//  CalendarTitle.h
//  MyCalendar
//
//  Created by cstlab on 14-10-12.
//  Copyright (c) 2014年 CSTTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarTitle : NSObject
@property (nonatomic)NSUInteger year;
@property (nonatomic)NSUInteger month;
-(CalendarTitle *)initWithMonth:(NSUInteger)month WithYear:(NSUInteger)year;
+(void)showWeekdayName;
-(void) showTitle;

@end
