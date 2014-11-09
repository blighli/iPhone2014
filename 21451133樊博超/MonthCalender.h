//
//  MonthCalender.h
//  homework1.0
//
//  Created by 樊博超 on 14-10-12.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#ifndef homework1_0_MonthCalender_h
#define homework1_0_MonthCalender_h

#import <Foundation/Foundation.h>
@interface MonthCalender : NSObject
{
    NSInteger _month;
    NSInteger _year;
}

-(void)drawbyMonth:(NSInteger)month andyear:(NSInteger)year;
-(void)drawbyYear:(NSInteger)year;
+(BOOL)isleapyear:(NSInteger)year;

@end

#endif
