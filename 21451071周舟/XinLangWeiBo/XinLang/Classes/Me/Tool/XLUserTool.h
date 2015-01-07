//
//  XLUserTool.h
//  XinLang
//
//  Created by 周舟 on 15/12/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLUserInfoParam.h"
#import "XLUserInfoResult.h"

@interface XLUserTool : NSObject

+ (void)userInfoWithParam:(XLUserInfoParam *)param success:(void(^)(XLUserInfoResult *result))success failure:(void(^)(NSError *error))failure;
@end
