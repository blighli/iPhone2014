//
//  DAO.m
//  RSSReader
//  Data Access Operations.
//  Created by Mz on 14-12-14.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "DAO.h"
#import "MWFeedInfo.h"
#import "MWFeedItem.h"
#import "FeedItem.h"
@implementation DAO

+ (void)save {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+ (NSArray *)fetchSources {
    return [FeedSource MR_findAllSortedBy:@"addTime" ascending:NO];
}

+(NSArray *)fetchItemsForSource:(FeedSource *)source {
    NSArray *items = [FeedItem MR_findByAttribute:@"source" withValue:source andOrderBy:@"date" ascending:NO];
    // 至多只保留50个
    for (int i = 50; i < items.count; i++) {
        FeedItem *item = [items objectAtIndex:i];
        [item MR_deleteEntity];
    }
    NSRange range;
    range.location = 0;
    range.length = items.count > 50 ? 50 : items.count;
    return [items subarrayWithRange:range];
}

+ (BOOL)isSourceURLExist:(NSURL *)url {
    return [FeedSource MR_findFirstByAttribute:@"url" withValue:[url absoluteString]] != nil;
}

+(void)addSourceWithDictionary:(NSDictionary *)dict {
    [DAO addSourceWithTitle:dict[@"title"] andUrl:[NSURL URLWithString:dict[@"url"]]];
}

+ (FeedSource*)addSourceWithTitle:(NSString *)title andUrl:(NSURL *)url {
    if ([DAO isSourceURLExist:url]) return nil;
    FeedSource *source = [FeedSource MR_createEntity];
    source.title = title;
    source.url = [url absoluteString];
    source.addTime = [NSDate date];
    [DAO save];
    return source;
}

+ (BOOL)isItemExist:(MWFeedItem *)item {
    return [FeedItem MR_findFirstByAttribute:@"identifier" withValue:item.identifier] != nil;
}

+ (void)addItems:(NSArray *)items toSource:(FeedSource *)source {
    int count = 0;
    for (MWFeedItem* item in items) {
        if ([DAO isItemExist:item]) continue;
        FeedItem *feedItem = [FeedItem MR_createEntity];
        feedItem.identifier = item.identifier;
        feedItem.title = item.title;
        feedItem.link = item.link;
        feedItem.date = item.date;
        feedItem.update = item.updated;
        feedItem.summary = item.summary;
        feedItem.content = item.content;
        feedItem.author = item.author;
        feedItem.isRead = @NO;
        feedItem.source = source;
        count++;
    }
    [DAO save];
    NSLog(@"%d new items has been added to source '%@'", count, source.title);
}

+ (NSInteger)countUnreadItemsForSource:(FeedSource *)source {
    NSArray *items = [FeedItem MR_findByAttribute:@"source" withValue:source andOrderBy:@"isRead" ascending:YES];
    NSInteger count = 0;
    for (FeedItem *item in items) {
        if ([item.isRead boolValue]) return count;
        count++;
    }
    return count;
}

+ (void)setItemRead:(FeedItem *)item {
    item.isRead = @YES;
    [DAO save];
}

+ (void)setAllItemsReadForSource:(FeedSource *)source {
    NSArray *items = [FeedItem MR_findByAttribute:@"source" withValue:source];
    for (FeedItem *item in items) {
        item.isRead = @YES;
    }
    [DAO save];
}

+ (void)setItemFavorite:(FeedItem *)item {
    item.isFavorite = @YES;
    [DAO save];
}

+ (NSArray *)fetchFavoriteItems {
    return [FeedItem MR_findByAttribute:@"isFavorite" withValue:@YES andOrderBy:@"date" ascending:NO];
}
@end
