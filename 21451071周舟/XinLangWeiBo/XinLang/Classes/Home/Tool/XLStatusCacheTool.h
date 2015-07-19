//
//  XLStatusCacheTool.h
//  XinLang
//
//  Created by 周舟 on 9/12/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLHomeStatusParam.h"

@class XLStatus;
@interface XLStatusCacheTool : NSObject

+ (void)addStatus:(NSDictionary *)dict;

+ (void)addStatuses:(NSArray *)dictArray;

+ (NSArray *)statuesWithParam:(XLHomeStatusParam *)param;
@end
