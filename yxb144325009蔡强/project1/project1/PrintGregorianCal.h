//
//  PrintGregorianCal.h
//  project1
//
//  Created by zack on 14-10-9.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrintCal : NSObject


+ (int) printCalByMonthAndYear:(int)month :(int)year;
+ (void) printCalByNow;
+ (void) printCalByMonth:(int)month;
+ (void) printCalByYear:(int)year;

@end
