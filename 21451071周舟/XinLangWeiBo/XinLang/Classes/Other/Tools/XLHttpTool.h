//
//  XLHttpTool.h
//  XinLang
//
//  Created by 周舟 on 14-9-30.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLHttpTool : NSObject

/**
 @brief	发送一个GET请求
 
 @param url [IN|OUT] 请求路径
 @param params [IN|OUT] 请求参数
 @param success [IN|OUT] 请求成功后的回调
 @param failure [IN|OUT] 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void(^)(NSError *error))failure;

/**
 @brief	发送一个GET请求
 
 @param url [IN|OUT] 请求路径
 @param params [IN|OUT] 请求参数
 @param success [IN|OUT] 请求成功后的回调
 @param failure [IN|OUT] 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray*)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  用来封装文件数据模型
 */

@end
@interface XLFormData: NSObject

@property(nonatomic, strong) NSData *data;
@property(nonatomic, copy) NSString *name;
@property (nonatomic, copy)NSString *filename;
@property (nonatomic, copy)NSString *minetype;

@end
