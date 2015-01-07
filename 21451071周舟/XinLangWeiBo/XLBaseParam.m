//
//  XLBaseParam.m
//  XinLang
//
//  Created by 周舟 on 9/12/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "XLBaseParam.h"
#import "XLAccount.h"
#import "XLAccountTool.h"

@implementation XLBaseParam
- (instancetype)init
{
    if (self = [super init]) {
        self.access_token = [XLAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end
