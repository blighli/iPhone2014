//
//  hero.m
//  FirethePlane
//
//  Created by qtsh on 14/12/15.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "hero.h"

@implementation hero

-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    self.physicsBody.collisionType = @"hero";
    NSLog(@"new hero");
}

@end