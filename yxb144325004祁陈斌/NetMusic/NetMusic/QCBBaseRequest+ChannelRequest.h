//
//  QCBBaseRequest+ChannelRequest.h
//  NetMusic
//
//  Created by xsdlr on 14/12/5.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "QCBBaseRequest.h"
#import "QCBChannelModel.h"

typedef void (^channelListSuccess)(NSArray* channelList);
typedef void (^channelListError)(NSError* error);
@interface QCBBaseRequest (ChannelRequest)
/**
 *  获得频道列表
 *
 *  @param path    请求地址
 *  @param success 成功回调
 *  @param fail    失败回调
 */
+ (void) channelList:(NSString*)path
             success:(channelListSuccess) success
                fail:(channelListError)fail;

@end
