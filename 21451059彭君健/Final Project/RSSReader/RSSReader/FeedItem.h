//
//  FeedItem.h
//  RSSReader
//
//  Created by Mz on 14-12-18.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FeedSource;

@interface FeedItem : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSNumber * isRead;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * update;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) FeedSource *source;

@end
