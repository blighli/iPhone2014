//
//  QCBBaseRequest.h
//  NetMusic
//
//  Created by xsdlr on 14/12/4.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^requestSuccess)(id jsonObject);
typedef void (^requestError)(NSError* error);
@interface QCBBaseRequest : NSObject

/**
 *  GET请求
 *
 *  @param path         请求地址
 *  @param parameters   请求参数
 *  @param success      成功回调
 *  @param fail         错误回调
 *
 *  @return AFHTTPRequestOperation 可通过该实例的cancel方法取消
 */
+ (AFHTTPRequestOperation*) GETRequestWithPath:(NSString*) path
                                    parameters:(NSDictionary*) parameters
                                       success:(requestSuccess) success
                                          fail:(requestError) fail;
/**
 *  解析JSON对象
 *
 *  @param jsonObject 原始数据对象
 *
 *  @return NSDictionary 或 nil
 */
+ (NSDictionary*) parseJSON:(NSObject*) jsonObject;
/**
 *  下载文件
 *
 *  @param path    文件地址
 *  @param rename  文件重命名名称
 *  @param success 成功回调
 *  @param fail    失败回调
 *
 *  @return NSURLSessionDownloadTask 可通过该实例的cancel方法取消
 */
+ (NSURLSessionDownloadTask*) downloadFile:(NSString*) path
                                    rename:(NSString*) rename
                                   success:(requestSuccess) success
                                      fail:(requestError) fail;
@end
