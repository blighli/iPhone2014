//
//  YearCal.m
//  homework1
//
//  Created by yingxl1992 on 14-10-18.
//  Copyright (c) 2014年 yingxl1992. All rights reserved.
//

#import "YearCal.h"
#import "MonthCal.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

@implementation YearCal

@synthesize year;

-(id)initWithYear:(NSInteger)y {
    if(self=[super init]){
        year=y;
    }
    return self;
}

-(void) outputYear {
    for (int i=1; i<=12; ) {
        MonthCal *cal1=[[MonthCal alloc]initWithYear:year AndMonth:i++];
        NSArray *mon1=[cal1 calOneMonth:1];
        MonthCal *cal2=[[MonthCal alloc]initWithYear:year AndMonth:i++];
        NSArray *mon2=[cal2 calOneMonth:1];
        MonthCal *cal3=[[MonthCal alloc]initWithYear:year AndMonth:i++];
        NSArray *mon3=[cal3 calOneMonth:1];
        for (int j=0; j<8; j++) {
            NSLog(@"%@  %@  %@",[mon1 objectAtIndex:j],[mon2 objectAtIndex:j],[mon3 objectAtIndex:j]);
        }
    }
}

@end
