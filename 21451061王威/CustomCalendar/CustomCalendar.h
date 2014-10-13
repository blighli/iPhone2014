//
//  CustomCalendar.h
//  CustomCalendar
//
//  Created by 王威 on 14-10-10.
//  Copyright (c) 2014年 com.MySuperCompany. All rights reserved.
//

#ifndef CustomCalendar_CustomCalendar_h
#define CustomCalendar_CustomCalendar_h
#import <Foundation/Foundation.h>
@interface CustomCalendar : NSObject
{
    NSDateComponents* comps;
    NSArray* daysOfMonth;
    NSArray* desOfMonth;
}

-(id) init;
-(void) setMonthWithCurrentYear: (long) month;
-(void) setMonth:(long) month Year: (long) year;
-(long) getTotalDays;
-(NSInteger) getFirstWeekday;
-(NSString*) description;

@end
#endif
