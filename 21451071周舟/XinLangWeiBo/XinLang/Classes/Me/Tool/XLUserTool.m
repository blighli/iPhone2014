//
//  XLUserTool.m
//  XinLang
//
//  Created by 周舟 on 15/12/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "XLUserTool.h"
#import "XLHttpTool.h"
#import "MJExtension.h"

@implementation XLUserTool

+ (void)userInfoWithParam:(XLUserInfoParam *)param success:(void (^)(XLUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [XLHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        
        
        if (success)
        {
            
            XLUserInfoResult *result = [XLUserInfoResult objectWithKeyValues:json];
            result.s_description = json[@"description"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            NSLog(@"--失败");
        }
    }];
}
@end
