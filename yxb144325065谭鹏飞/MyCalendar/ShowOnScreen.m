//
//  ShowOnScreen.m
//  MyCalendar
//
//  Created by cstlab on 14-10-11.
//  Copyright (c) 2014年 CSTTan. All rights reserved.
//

#import "ShowOnScreen.h"

@implementation ShowOnScreen
@synthesize whichWeekday = _whichWeekday;
@synthesize monthdays = _monthdays;

-(ShowOnScreen *)initforweekday:(NSInteger)whichWeekday formonthdays:
       (NSInteger)monthdays{
    self.whichWeekday = whichWeekday;
    self.monthdays = monthdays;
    return self;
}

-(void)ShowCalendar{
    [self dealTab:(self.whichWeekday-1)*4];
    for (int i = 1; i <= self.monthdays; i++) {
        if (self.whichWeekday > 7 && self.whichWeekday%7 ==1) {
            printf("\n");
        }
        if (i < 10) {
            printf("0%d",i);
        }else{
            printf("%d", i);
        }
        [self dealTab:2];
        self.whichWeekday++;
    }
    printf("\n");
}

-(void)dealTab:(NSInteger) tabCount{
    for (int i=0; i < tabCount; i++) {
        printf(" ");
    }

}
@end
