//
//  XLHttpTool.m
//  XinLang
//
//  Created by 周舟 on 14-9-30.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLHttpTool.h"
#import <AFNetworking/AFNetworking.h>

@implementation XLHttpTool

/**
 *  POST
 *
 *  @param url     网址
 *  @param params  参数
 *  @param success 成功后执行的blcok
 *  @param failure 失败后执行的block
 */


+(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/html",nil];
    //mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    //2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *  Post 发送图片
 *
 *  @param url           网址
 *  @param params        参数
 *  @param formDataArray 要发送的数据
 *  @param success       成功后执行
 *  @param failure       失败后执行
 */

+(void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
  
    
    //2.发送请求//
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (XLFormData *data in formDataArray) {
            [formData appendPartWithFileData:data.data name:data.name fileName:data.filename mimeType:data.minetype];
            
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


/**
 *  GET 发送请求
 *
 *  @param url     网址
 *  @param params  参数
 *  @param success 成功的执行的block
 *  @param failure 失败后执行的block
 */
+(void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end

@implementation XLFormData



@end
