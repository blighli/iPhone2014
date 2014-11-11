//
//  Utils.m
//  homework1
//
//  Created by yingxl1992 on 14-10-18.
//  Copyright (c) 2014年 yingxl1992. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(NSString *)addSpace:(NSInteger)n string:(NSString *)str len:(NSInteger)len {
    int left=(n-len)/2;
    int i;
    NSMutableString *str1=[NSMutableString string];
    for (i=1; i<=left; i++) {
        [str1 appendString:@" "];
    }
    [str1 appendString:str];
    i+=len;
    for (; i<=n; i++) {
        [str1 appendString:@" "];
    }
    return str1;
}

@end
