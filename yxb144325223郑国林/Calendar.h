//
//  Calendar.h
//  Perject1
//
//  Created by Mac on 14-10-8.
//  Copyright (c) 2014年 Mac. All rights reserved.
//


#ifndef Perject1_Calender_h
#define Perject1_Calender_h
#import <cocoa/cocoa.h>

@interface Module : NSObject
{
    int month;     int firstDay;
    int posation;  int days;
    int year;
}

- (void) setFirstDay:(int) day andMonth:(int) mounth1 andYear:(int) year1;
- (void) setOutput;
- (void) resetPosation;

@end
@interface Calendar : NSObject
{
    int year;
    int month;
    int num;
    Module *md[12];
}

- (void) setYear:(int) newYear;
- (void) setMonth:(int) newMonth;
- (void) setNum:(int) newNum;
- (int) forFirstDay:(int) day1 andMonth:(int) month1;
- (void) print;
@end


#endif
