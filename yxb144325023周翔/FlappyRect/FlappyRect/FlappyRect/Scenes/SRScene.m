//
//  SRScene.m
//  FlappyRect
//
//  Created by ZhouXiang on 14-12-23.
//  Copyright (c) 2014年 ZhouXiang. All rights reserved.
//

#import "SRScene.h"

@interface SRScene()

@property BOOL contentCreated;

@end

@implementation SRScene

- (void)didMoveToView:(SKView *)view
{
    if (_contentCreated) {
        return;
    }
    
    [self initalize];
    self.contentCreated = YES;
}

- (void)initalize
{
    
}

@end
