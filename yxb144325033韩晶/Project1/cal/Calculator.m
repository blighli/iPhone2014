//
//  Calculator.m
//  cal
//
//  Created by hanxue on 14-10-11.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator : NSObject 
-(NSString *) getTodayDate
{
    // NSDate *data = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM"];
    
    NSString *str = [df stringFromDate:[NSDate date]];
    return str;
}

@end
