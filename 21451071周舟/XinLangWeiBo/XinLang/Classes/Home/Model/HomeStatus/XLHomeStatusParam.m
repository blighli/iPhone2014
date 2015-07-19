//
//  XLHomeStatusParam.m
//  XinLang
//
//  Created by 周舟 on 9/12/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "XLHomeStatusParam.h"

@implementation XLHomeStatusParam
- (NSNumber *)count
{
    return _count ? _count : @20;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"token:%@, count:%@, max_id:%@, since_id:%@",self.access_token,self.count, self.max_id, self.since_id];
}
@end
