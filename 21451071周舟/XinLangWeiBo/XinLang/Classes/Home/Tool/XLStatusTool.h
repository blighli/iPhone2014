//
//  XLStatusTool.h
//  XinLang
//
//  Created by 周舟 on 14-10-6.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>



@class XLHomeStatusParam,XLHomeStatusResult;

@interface XLStatusTool : NSObject
/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeStatusesWithParam:(XLHomeStatusParam *)param success:(void(^)(XLHomeStatusResult *result))success failure:(void(^)(NSError *error))failure;

@end