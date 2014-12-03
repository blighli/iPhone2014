//
//  HistoryAction.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/3.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HistoryAction : NSManagedObject

@property (nonatomic, retain) NSString * habitId;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSDate * actionTime;

@end
