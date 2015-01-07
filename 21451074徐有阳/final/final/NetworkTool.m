//
//  NetworkTool.m
//  final
//
//  Created by xuyouyang on 14/12/25.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "NetworkTool.h"
#import "AFHTTPRequestOperationManager.h"
#import "Post.h"

@implementation NetworkTool

- (void)getDataWithUrl:(NSString *)url completion:(void (^)(id))completion {
    
}

- (void)getPostWithType:(NSString *)type success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://crawler-cst.herokuapp.com/post" parameters:@{@"type": type} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 包装post数组
        NSArray *tmpPosts = [responseObject objectForKey:@"posts"];
        NSMutableArray *posts = [[NSMutableArray alloc] init];
        for (id tmpPost in tmpPosts) {
            Post *post = [[Post alloc]init];
            post._id = [tmpPost valueForKey:@"_id"];
            post.title = [tmpPost valueForKey:@"title"];
            post.url = [tmpPost valueForKey:@"link"];
            post.type = [tmpPost valueForKey:@"type"];
            post.publishTime = [tmpPost valueForKey:@"publish_time"];
            [posts addObject:post];
        }
        success(posts);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}

@end
