//
//  MyCalendar.h
//  sunny
//
//  Created by sunny on 14-10-17.
//  Copyright (c) 2014年 sunny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject

@property (retain) NSDateComponents* components;

- (instancetype) initWithYear:(int) year;
- (instancetype) initWithYear:(int) year andMonth:(int) month;
- (instancetype) initWithMonth:(int) month;

+ (void) setMonthWithComponents:(NSDateComponents *) comp
                                into:(NSArray *) ss
                             hasYear:(BOOL) hasYear;
- (void) printYear;
- (void) printMonth;

@end
