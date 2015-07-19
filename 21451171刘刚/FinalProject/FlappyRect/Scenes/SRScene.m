//
//  SRScene.m
//  FlappyRect
//
//  Created by lg on 14-12-1.
//  Copyright (c) 2014年 lg. All rights reserved.
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
