//
//  FeedSource.h
//  RSSReader
//
//  Created by Mz on 14-12-14.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreData+MagicalRecord.h"
@class FeedItem;

@interface FeedSource : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSDate * addTime;
@property (nonatomic, retain) NSSet *items;
@end

@interface FeedSource (CoreDataGeneratedAccessors)

- (void)addItemsObject:(FeedItem *)value;
- (void)removeItemsObject:(FeedItem *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
