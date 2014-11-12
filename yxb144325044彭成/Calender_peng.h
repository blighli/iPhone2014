//
//  Calender_peng.h
//  OC_Assignment_1
//
//  Copyright (c) 2014年 pengcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calender_peng : NSObject

+ (void) printMonth:(int) month andYear:(int) year;

+ (void) printYear:(int) year;

+ (int) firstWeekDay:(int) month andYear:(int)year;

+ (int) getDayCount:(int)month andYear:(int)year;

@end
