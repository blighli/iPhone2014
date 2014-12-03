//
//  Habit.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/3.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Habit : NSManagedObject

@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * period;
@property (nonatomic, retain) NSNumber * times;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSDate * doTime;
@property (nonatomic, retain) NSDate * postponeTime;
@property (nonatomic, retain) NSDate * nextDoTime;
@property (nonatomic, retain) NSDate * periodEndTime;

@end
