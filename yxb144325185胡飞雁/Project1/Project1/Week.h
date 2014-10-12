//
//  Week.h
//  Project1
//
//  Created by  sephiroth on 14-10-7.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Module : NSObject
{
    int month;
    int firstDay;
    int posation;
    int days;
    int year;
    NSString *output;
}

- (void) setFirstDay:(int) day andMonth:(int) m andYear:(int) y;
- (void) setOutput;
- (void) resetPosation;

@end


@interface Week : NSObject
{
    int year;
    int month;
    int num;
    Module *md[12];
}

- (void) setYear:(int) newYear;
- (void) setMonth:(int) newMonth;
- (void) setNum:(int) newNum;
- (int) forFirstDay:(int) d andMonth:(int) m;
- (void) print;
@end



