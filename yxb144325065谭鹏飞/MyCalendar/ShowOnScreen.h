//
//  ShowOnScreen.h
//  MyCalendar
//
//  Created by cstlab on 14-10-11.
//  Copyright (c) 2014年 CSTTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowOnScreen : NSObject
@property (nonatomic)NSInteger whichWeekday;;
@property (nonatomic)NSInteger monthdays;
-(ShowOnScreen *)initforweekday:(NSInteger)whichWeekday formonthdays:
       (NSInteger)monthdays;
-(void)ShowCalendar;
@end
