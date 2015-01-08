//
//  Enemy3.m
//  FirethePlane
//
//  Created by qtsh on 14/12/15.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enemy3.h"

@implementation Enemy3

-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    self.physicsBody.collisionType =@"Enemy3";
    hitCount = 0;
}

@end