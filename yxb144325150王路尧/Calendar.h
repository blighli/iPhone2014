//
//  calendar.h
//  project_1
//
//  Created by 王路尧 on 14-10-10.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Module : NSObject
{
    int month;
    int firstday;
    int posation;
    int days;
    int year;
    NSString *output;
}

-(void) setFirstday:(int)day andMonth:(int)m andYear:(int) y;
-(void) setOutput;
-(void) resetPosation;

@end


@interface calendar : NSObject
{
    int year;;
    int month;
    int num;
    Module *md[12];
}

-(void) setYear:(int)newYear;
-(void) setMonth:(int) newMonth;
-(int) forFirstday:(int) d andMonth:(int)m;
-(void) print;
@end
