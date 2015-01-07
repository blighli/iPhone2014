//
//  XLHomeStatusResult.m
//  XinLang
//
//  Created by 周舟 on 9/12/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "XLHomeStatusResult.h"
#import "XLStatus.h"
#import "MJExtension.h"

@implementation XLHomeStatusResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [XLStatus class]};
}
@end
