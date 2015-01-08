//
//  Enemy1.m
//  FirethePlane
//
//  Created by qtsh on 14/12/15.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enemy1.h"
@implementation Enemy1
-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    self.physicsBody.collisionType =@"Enemy1";
}
@end