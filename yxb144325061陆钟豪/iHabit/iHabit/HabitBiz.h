//
//  HabitBiz.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/8.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Habit.h"

@interface HabitBiz : NSObject
@property (strong, nonatomic, readonly) NSArray* habitArray;

-(NSInteger)done:(Habit*)habit;
-(NSInteger)skip:(Habit*)habit;
-(Habit*)saveHabitWithTitle:(NSString*)title iconKey:(NSString*)iconKey period:(HabitPeriod)period times:(NSNumber*)times;

+(HabitBiz*)getInstance;

@end
