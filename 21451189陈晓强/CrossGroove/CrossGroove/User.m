//
//  User.m
//  CrossGroove
//
//  Created by 陈晓强 on 14/12/24.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize accountNumber;
@synthesize password;


- (void)setUsername:(NSString *)user
{
    if (![accountNumber isEqual:user]) {
        accountNumber = [user copy];
    }
}


- (void)setPassword:(NSString *)psw
{
    if (![password isEqual:psw]) {
        password = [psw copy];
    }
}

@end
