//
//  WyzCalender.h
//  calendar_project1
//
//  Created by alwaysking on 14-10-12.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WyzCalendar : NSObject

{
    
}

+(void) setCurrentYear:(int)year andMonth:(int)month;
+(void) setYear:(int)year;
+(void) showCalendarSetYear:(int)year andMonth:(int)month;
+(void) calculateYear:(int)year andMonth:(int)month;
@end
