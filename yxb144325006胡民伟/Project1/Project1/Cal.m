//
//  Cal.m
//  Project1
//
//  Created by Cocoa on 14-10-7.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "Cal.h"
@implementation Cal
- (id)init {
    self = [super init];
    if (self) {
        self->gregorian = [[NSCalendar alloc]initWithCalendarIdentifier: NSGregorianCalendar];
    }
    return self;
}

- (void)printCalendar:(NSUInteger)year andMonth: (NSUInteger)month{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:month];
    [components setYear:year];
    
    NSDate *firteDay = [gregorian dateFromComponents:components];
    NSUInteger day = [gregorian ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:firteDay]-1;
    NSUInteger totalDays = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[gregorian dateFromComponents:components]].length;
    
    printf("  日   一   二   三    四   五    六\n");
    for (int i = 0; i < day; i++) {
        printf("     ");
    }
    
    for(int i=1; i<=totalDays; i++){
        if (i<10) {
            printf("  %d  ",i);
        }
        else{
            printf("  %d ",i);
        }
        if (day==0) {
            if (i%7==0) {
                printf("\n");
            }
        }
        else{
            if(i%7==(7-day)){
                printf("\n");
            }
        }
    }
    printf("\n\n");
}
@end