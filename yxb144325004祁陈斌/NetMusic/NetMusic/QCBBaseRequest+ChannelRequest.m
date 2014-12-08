//
//  QCBBaseRequest+ChannelRequest.m
//  NetMusic
//
//  Created by xsdlr on 14/12/5.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "QCBBaseRequest+ChannelRequest.h"

@implementation QCBBaseRequest (ChannelRequest)

+ (void)channelList:(NSString *)path
            success:(channelListSuccess)success
               fail:(channelListError)fail {
    NSMutableArray *result = [NSMutableArray array];
    //转交全局线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [QCBBaseRequest GETRequestWithPath:path parameters:nil success:^(NSDictionary* jsonObject) {
            if (jsonObject) {
                NSArray *channels = [jsonObject objectForKey:@"channels"];
                if (channels) {
                    for (NSDictionary* dic in channels) {
                        QCBChannelModel *model = [QCBChannelModel new];
                        [model setValuesForKeysWithDictionary:dic];
                        [result addObject:model];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(result);
                    });
                }
            }
        } fail:^(NSError* error) {
            dispatch_async(dispatch_get_main_queue(), ^{
               fail(error);
            });
        }];
    });
}
@end
