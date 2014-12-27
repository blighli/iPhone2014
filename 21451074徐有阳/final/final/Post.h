//
//  Post.h
//  final
//
//  Created by xuyouyang on 14/12/27.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* publishTime;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* type;

- getPostCompletion:(void (^)(id responseData))completion;

@end
