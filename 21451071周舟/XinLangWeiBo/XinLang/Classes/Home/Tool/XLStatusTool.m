//
//  XLStatusTool.m
//  XinLang
//
//  Created by 周舟 on 14-10-6.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLStatusTool.h"
#import "MJExtension.h"
#import "XLStatusCacheTool.h"
#import "XLHttpTool.h"
#import "XLHomeStatusParam.h"
#import "XLHomeStatusResult.h"
#import "XLStatus.h"

@implementation XLStatusTool

+(void)homeStatusesWithParam:(XLHomeStatusParam *)param success:(void (^)(XLHomeStatusResult *))success failure:(void (^)(NSError *))failure
{
    
    NSArray *dicArray = [XLStatusCacheTool statuesWithParam:param];
    
    if (dicArray.count) {
        if (success) {
            XLHomeStatusResult *result = [[XLHomeStatusResult alloc] init];
            //result.statuses = statusArray;
            
            result.statuses = [XLStatus objectArrayWithKeyValuesArray:dicArray];
            success(result);
        }
    }
    else
    {
        [XLHttpTool getWithURL:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:param.keyValues success:^(id json){
            //NSLog(@"json:%@",json);
            [XLStatusCacheTool addStatuses:json[@"statuses"]];
            
            if (success)
            {
                XLHomeStatusResult *result = [XLHomeStatusResult objectWithKeyValues:json];
                success(result);
            }
        } failure:^(NSError *error){
            if (failure)
            {
                failure(error);
            }
        }];
    }
}
@end
