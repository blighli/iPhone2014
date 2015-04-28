//
//  Bullet1.m
//  FirethePlane
//
//  Created by qtsh on 14/12/14.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bullet1.h"
@implementation Bullet1
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"bullet animation stop");
}
-(void)onExit
{
    [super onExit];
    NSLog(@"bullet leaves");
}
-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    self.physicsBody.collisionType =@"Bullet1";
}

@end