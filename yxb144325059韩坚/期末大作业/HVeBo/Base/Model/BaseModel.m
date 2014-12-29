//
//  BaseModel.m
//  HVeBo
//
//  Created by HJ on 14/12/18.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _ID = [dict[@"id"]longLongValue];
        self.createdAt = dict[@"created_at"];
    }
    return self;
}
- (NSString *)createdAt
{
    //Sun Dec 07 10:53:02 +0800 2014
    NSDateFormatter *format = [NSDateFormatter new];
    format.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    format.locale  =[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [format dateFromString:_createdAt];
    format.dateFormat = @"MM-dd";
    
    //和当前时间进行比较
    NSDate *now = [NSDate date];
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
    if (delta < 600) {
        return @"刚刚";
    }else if(delta < 3600){
        return [NSString stringWithFormat:@"%.f分钟前",delta/60];
    }else if(delta < 3600*24){
        return [NSString stringWithFormat:@"%.f小时前",delta/3600];
    }else{
        return [format stringFromDate:date];
    }
}
@end
