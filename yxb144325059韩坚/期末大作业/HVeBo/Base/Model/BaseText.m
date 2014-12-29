//
//  BaseTest.m
//  HVeBo
//
//  Created by HJ on 14/12/16.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseText.h"
#import "User.h"

@implementation BaseText
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict: dict]) {

    self.text = dict[@"text"];
        self.user = [[User alloc] initWithDict:dict[@"user"]];
    }
    return self;
}

@end
