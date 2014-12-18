//
//  DAO.h
//  RSSReader
//
//  Created by Mz on 14-12-14.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"
#import "FeedSource.h"

@interface DAO : NSObject
+ (void)save;
+ (NSArray*)fetchSources;
+ (NSArray*)fetchItemsForSource:(FeedSource *)source;
+ (void)addSourceWithDictionary:(NSDictionary *)dict;
+ (FeedSource *)addSourceWithTitle:(NSString *)title andUrl:(NSURL *)url;
+ (void)addItems:(NSArray *)items toSource:(FeedSource *)source;
+ (NSInteger)countUnreadItemsForSource:(FeedSource *)source;
+ (void)setItemRead:(FeedItem *)item;
+ (void)setAllItemsReadForSource:(FeedSource *)source;
+ (void)setItemFavorite:(FeedItem *)item;
+ (NSArray*)fetchFavoriteItems;
@end
