//
//  HistoryPeriod.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/3.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HistoryPeriod : NSManagedObject

@property (nonatomic, retain) NSString * habitId;
@property (nonatomic, retain) NSNumber * period;
@property (nonatomic, retain) NSNumber * times;
@property (nonatomic, retain) NSDate * periodEndTime;
@property (nonatomic, retain) NSDate * doneTimes;

@end
