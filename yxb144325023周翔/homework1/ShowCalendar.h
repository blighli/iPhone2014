//
//  ShowCalendar.h
//  ZhouXiang
//
//  Created by 周翔 on 14-10-16.
//  Copyright (c) 2014年 周翔. All rights reserved.
//

#ifndef ZhouXiang_ShowCalendar_h
#define ZhouXiang_ShowCalendar_h

@interface ShowCalendar : NSObject

-(void) printOneMonthCalendar:(int) month Year:(int) year;

-(void) printWholeYearCalendar:(int) month Year:(int) year;

-(int) SumOfMonth:(int) month Year:(int) year;

-(int) FirstDate:(int) month Year:(int) year;



@end


#endif
