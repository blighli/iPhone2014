//
//  calendar.h
//  cal
//
//  Created by Devon on 14-10-6.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#ifndef cal_calendar_h
#define cal_calendar_h

@interface DATE2WEEKDAY : NSObject
@property int date;
@property int weekday;

@end

@interface MONTHDAY : NSObject  {
    DATE2WEEKDAY *date2weekday[31];
}

-(id)init;

-(int)WeekdayAtIndex: (int)index;

-(void)setWeekdayAtIndex: (int)index value: (int)value;

-(int)DateAtIndex: (int)index;

-(void)setDateAtIndex:(int)index value: (int)value;

@property int days;
@end

@interface Calendar : NSObject

+(int)displaymonth: (int)year month:(int)month;

+(int)displayyear: (int)year;

+(int)JulianCalendar: (int)year month:(int)month weekday:(MONTHDAY*)monthday;

+(int)GregorianCalendar: (int)year month:(int)month weekday:(MONTHDAY*)monthday;

+(int)Special1752: (int)year month:(int)month weekday:(MONTHDAY*)monthday;

@end

#endif
