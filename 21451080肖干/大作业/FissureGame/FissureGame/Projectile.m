//
//  Projectile.m
//  FissureGame
//
//  Created by xiaoo_gan on 12/23/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "Projectile.h"

@implementation Projectile

@synthesize node;
@synthesize emitter;
@synthesize color;

- (id) initWithPosition:(SpawnPoint *) point {
    if (self = [super init]) {
        //创建发射物
        node = [[SKSpriteNode alloc] initWithImageNamed:@"line5x1"];
        //发射物的初始发射位置
        node.position = CGPointMake(point.position.x + floatBetween(-point.positionJitter.width, point.positionJitter.width),
                                    point.position.y + floatBetween(-point.positionJitter.height, point.positionJitter.height));
        //发射物颜色
        color = point.color;
        node.color = color;
        //纹理颜色混合因子
        node.colorBlendFactor = 1;
        //设置发射物在物理世界的属性
        node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:PROJECTILE_PHYS_RADIUS];
        node.physicsBody.velocity = point.initialVelocity;
        node.physicsBody.friction = point.friction;
        node.physicsBody.affectedByGravity = NO;
        node.physicsBody.allowsRotation = YES;
        node.physicsBody.linearDamping = point.friction;
        node.physicsBody.restitution = 1;
        //发射物形状方向
        node.zRotation = atan2(node.physicsBody.velocity.dy,
                               node.physicsBody.velocity.dx);
        
        //标记发射物
        node.physicsBody.categoryBitMask = PHYS_CAT_PROJ;
        node.physicsBody.collisionBitMask = PHYS_CAT_CONTROL_COLL;
        //当发射物与下列对象发生碰撞事，发出通知给contactDelegate
        node.physicsBody.contactTestBitMask = PHYS_CAT_EDGE | PHYS_CAT_CONTROL_TRANS
                                                            | PHYS_CAT_TARGET
                                                            | PHYS_CAT_FISSURE
                                                            | PHYS_CAT_CONTROL_COLL;
        
        //发射物 尾迹
        emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:
                                  [[NSBundle mainBundle] pathForResource:@"projectile_trail"
                                                                  ofType:@"sks"]];
        CGFloat r, g, b, a;
        [point.color getRed:&r green:&g blue:&b alpha:&a];
        emitter.particleColorSequence = [[SKKeyframeSequence alloc] initWithKeyframeValues:
                                         @[[UIColor colorWithRed:r green:g blue:b alpha:0.15],
                                           [UIColor colorWithRed:r green:g blue:b alpha:0]]
                                                                                     times:@[@(0), @(1)]];
        [node addChild:emitter];
        node.userData = [NSMutableDictionary dictionaryWithDictionary:@{@"emitter":emitter}];
    }
    return self;
}

@end
