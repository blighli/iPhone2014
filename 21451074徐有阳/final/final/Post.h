//
//  Post.h
//  final
//
//  Created by xuyouyang on 14/12/27.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic, strong) NSString* _id;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* publishTime;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* type;

- (void)getPostWithType:(NSString *)type success:(void (^)(id responseData))success failure:(void (^)(NSError *error))failure;

@end
