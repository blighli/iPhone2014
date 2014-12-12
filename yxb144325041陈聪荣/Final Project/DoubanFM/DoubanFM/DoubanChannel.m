//
//  DouabanChannel.m
//  DoubanFM
//
//  Created by 陈聪荣 on 14/12/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "DoubanChannel.h"

@implementation DoubanChannel

-(instancetype)initWithName:(NSString*) name andChannelId:(NSInteger) channel_id{
    if(self = [super init]){
        _name = name;
        _channel_id = channel_id;
    }
    return self;
}
@end
