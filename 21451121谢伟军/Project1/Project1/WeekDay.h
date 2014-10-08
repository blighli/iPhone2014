//
//  WeekDay.h
//  Project1
//
//  Created by xvxvxxx on 14-10-8.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeekDay : NSObject
-(NSInteger)weekDay;
-(NSInteger)numberOfDayInMonth;
-(id)initWithInputDayWithYear:(NSInteger)year Month:(NSInteger)month;
-(id)initWithToday;
@property NSInteger month;
@property NSInteger year;
@end
