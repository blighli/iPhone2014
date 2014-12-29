//
//  Status.m
//  HVeBo
//
//  Created by HJ on 14/12/6.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "Status.h"

@implementation Status

 - (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {

        _picUrls = dict[@"pic_urls"];
        NSDictionary *retweeted = dict[@"retweeted_status"];
        if (retweeted) {
            _retweetedStatus = [[Status alloc] initWithDict:dict[@"retweeted_status"]];
        }
        _source = dict[@"source"];
        _repostsCount = [dict[@"reposts_count"] intValue];
        _commentCount = [dict[@"comments_count"] intValue];
        _attitudesCount = [dict[@"attitudes_count"] intValue];
    }
    return self;
}

- (NSString *)source
{
    if (_source.length == 0) {
        return @" ";
    }else{
        NSInteger begin = [_source rangeOfString:@">"].location;
        NSInteger end= [_source rangeOfString:@"</"].location;
        return  [NSString stringWithFormat:@"来自%@",[_source substringWithRange:NSMakeRange(begin+1, end - begin-1)]];
    }
}
@end
