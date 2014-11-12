//
//  Calendar.h
//  cal
//
//  Created by hanxue on 14-10-11.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calendar : NSObject
-(NSString *) getTodayDate;     //2014-10
-(void) printCal:(NSString*) dateForm andDecYear:(BOOL) dec;
-(void) printDia:(NSInteger[]) year andMonth:(NSInteger[]) month andWeekDay:(NSInteger[]) weekday andDecAllYear:(BOOL) decOneYear andDecFirstTime:(BOOL) decFirstTime;
-(NSString *) getTodayDateHaveTwoData:(NSString*)first andSecond:(NSString*)second;  //first 为年 second 为月
-(void) printByYear:(NSString *)first;
-(BOOL) printOneRow:(NSInteger) start andEndNum:(NSInteger) end andWeekNum:(NSInteger) week;
@end
