//
//  ShowOnScreen.h
//  MyCalendar
//
//  Created by cstlab on 14-10-11.
//  Copyright (c) 2014年 CSTTan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowOnScreen : NSObject
@property (nonatomic)NSUInteger whichWeekday;
@property (nonatomic)NSUInteger monthdays;
-(instancetype)initForweekday:(NSUInteger)whichWeekday formonthdays:(NSUInteger)monthdays;
-(void)ShowCalendar;
@end
