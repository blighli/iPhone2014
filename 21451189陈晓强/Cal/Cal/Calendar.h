//
//  Calendar.h
//  Cal
//
//  Created by 陈晓强 on 14-10-6.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject

@property (nonatomic) NSUInteger day;
@property (nonatomic) NSUInteger month;
@property (nonatomic) NSUInteger year;
- (void) monthOfYearArray;
- (void) printCalendarForYear;
- (void) printCalendarForMonth;

@end
