//
//  printCalendar.h
//  project1
//
//  Created by Van on 14-10-6.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

static const char  WeekdayName[] = {
    " Sun  Mon  Tue  Wed  Thu  Fri  Sat "
};
static const char *monthName[]= {
    "January", "February", "March", "April",
    "May", "June", "July", "August",
    "September", "October", "November", "December",
};
@interface printCalendar : NSObject
-(void) printCalendarWith:(NSDateComponents *)comps :(BOOL)inSingMonth;
+(void) printSpecialMonth:(NSDateComponents *)comps :(BOOL)inSingMonth;
+(void) printTitle:(NSDateComponents *)comps :(BOOL)inSingMonth;
+(long) ConvertToJulian:(NSDateComponents *)comps :(NSUInteger)dayNum;
+(void) printCalendarWith:(NSDateComponents *)comps :(BOOL)with1752Flag;
@end
