//
//  Header.h
//  cal
//
//  Created by Mac on 14-10-13.
//  Copyright (c) 2014年 Mac. All rights reserved.
//


#ifndef cal_Header_h
#define cal_Header_h

#import<Cocoa/Cocoa.h>
int Date[24][21];
int argc;

@interface Month : NSObject{
    int year;
    int month;
    int days;
    int firstday;
}

-(void) setYear:(int)year;
-(void) setMonth:(int)month;
-(void) setDays:(int)days;
-(void) setFirstday:(int)firstday;
-(void) Countdays:(int)y andmonth:(int)m;
-(void) Output;

@end

@interface Cal : NSObject{
    int argv1;
    int argv2;
    Month * month[12];
}
-(void) setCanshuNum:(int)num ;
-(void) setArgv1:(int)agv1;
-(void) setArgv2:(int) agv2;
-(void) OutputAll;


@end


#endif
