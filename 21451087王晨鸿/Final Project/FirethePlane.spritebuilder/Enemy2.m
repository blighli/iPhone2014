//
//  Enemy2.m
//  FirethePlane
//
//  Created by qtsh on 14/12/15.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enemy2.h"

@implementation Enemy2

-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    self.physicsBody.collisionType =@"Enemy2";
}

@end