//
//  Util.m
//  mycal
//
//  Created by Hao on 14-10-6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "Util.h"

NSString* createMidTitle(NSString* title, NSInteger diplayLenOfTitle, NSInteger length) {
    NSInteger numOfBlank = length - diplayLenOfTitle;
    NSInteger offset = numOfBlank / 2;
    NSMutableString* resultStr = [NSMutableString new];
    for(NSInteger i = 0; i < numOfBlank; ++i) {
        [resultStr appendString:@" "];
    }
    [resultStr insertString:title atIndex:offset];
    return resultStr;
}