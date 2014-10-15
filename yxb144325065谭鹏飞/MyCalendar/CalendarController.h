//
//  CalendarController.h
//  MyCalendar
//
//  Created by cstlab on 14-10-11.
//  Copyright (c) 2014年 CSTTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarController : NSObject
@property (strong, nonatomic)NSArray * commandArray;;
@property (strong, nonatomic)NSDateComponents * date;
-(CalendarController *)initWithCommandStr:(NSArray *)commands;
-(int)dealWithCommandStr;
+(BOOL)isPureInt:(NSString *) sourceStr;
@end
