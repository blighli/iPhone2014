//
//  ZYCal.h
//  Cal_HomeWork
//
//  Created by StarJade on 14-10-12.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutMonth.h"


@interface ZYCal : NSObject
{
    OutMonth *outMonth;
    int _cntYear;
    int _cntMonth;
}

- (instancetype)init;
//
- (void)input;
- (void)inputWithOne: (const char *)one;
- (void)inputWithOne: (const char *)one Two: (const char *)two;
//
- (BOOL)judgeYear:(int)year;
- (BOOL)judgeMonth:(int)month;

//
- (void)outCurrentMonth;
- (void)outMonthAtYear:(int)year AtMonth:(int) month;
- (void)outMonthAt:(int)month;
- (void)outYearAt:(int)year;

@end
