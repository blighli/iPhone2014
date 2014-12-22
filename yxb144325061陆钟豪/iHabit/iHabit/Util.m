//
//  Util.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/22.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "Util.h"

@implementation ActionBlock {
    void (^_block)(id sender) ;
}

-(instancetype)initWith:(void (^)(id sender))block {
    self = [super init];
    _block = block;
    return self;
}

-(void)action:(id) sender{
    _block(sender);
};

@end

@implementation Util

+(id)blockActionWithBlock:(void (^)(id sender))block {
    return [[ActionBlock alloc] initWith:block];
};

@end
