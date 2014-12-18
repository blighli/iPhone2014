//
//  MWFeedParserWrapper.h
//  RSSReader
//
//  Created by Mz on 14-12-11.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWFeedParser.h"
enum {FeedParseSuccess, FeedParseFailed, FeedParseTimeout};
typedef void (^FeedParserCompletionHandler)(int retCode, MWFeedInfo *info, NSArray *items);

@interface FeedParserWrapper : NSObject<MWFeedParserDelegate>
- (void)parseUrl:(NSURL *)url timeout:(NSTimeInterval)timeout completion:(FeedParserCompletionHandler)completionHandler;
@end
