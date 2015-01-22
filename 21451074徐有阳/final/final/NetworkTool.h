//
//  NetworkTool.h
//  final
//
//  Created by xuyouyang on 14/12/25.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTool : NSObject

- (void)getDataWithUrl:(NSString *)url completion:(void (^)(id responseData))completion;
- (void)getPostWithType:(NSString *)type success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

@end
