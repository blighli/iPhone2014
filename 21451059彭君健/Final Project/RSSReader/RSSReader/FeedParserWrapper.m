//
//  MWFeedParserWrapper.m
//  RSSReader
//
//  Created by Mz on 14-12-11.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "FeedParserWrapper.h"

@interface FeedParserWrapper()
@property (nonatomic, strong) FeedParserCompletionHandler completion;
@property (nonatomic, strong) MWFeedInfo *info;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) MWFeedParser *feedParser;
@property (nonatomic) BOOL isFinished;
@end

@implementation FeedParserWrapper

- (void)parseUrl:(NSURL *)url timeout:(NSTimeInterval)timeout completion:(FeedParserCompletionHandler)completionHandler {
    _feedParser = [[MWFeedParser alloc] initWithFeedURL:url];
    _feedParser.delegate = self;
    _feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
    _feedParser.connectionType = ConnectionTypeAsynchronously;
    _completion = completionHandler;
    _isFinished = NO;
    [_feedParser parse];
    [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(timeoutHandler) userInfo:nil repeats:NO];
}

- (void)timeoutHandler {
    if (!_isFinished) {
        _isFinished = YES;
        _completion(FeedParseTimeout, nil, nil);
        [_feedParser stopParsing];
    }
}

#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
    _info = nil;
    _items = nil;
    _items = [NSMutableArray array];
    NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"Parsed Feed Info Title: “%@”", info.title);
    _info = info;
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"Parsed Feed Item: “%@”", item.title);
    [_items addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @"."));
    if (!_isFinished) {
        _isFinished = YES;
        _completion(FeedParseSuccess, _info, _items);
    }
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Finished Parsing With Error: %@", error);
    if (!_isFinished) {
        _isFinished = YES;
        _completion(FeedParseFailed, nil, nil);
    }
}
@end
