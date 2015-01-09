//
//  Projectile.h
//  FissureGame
//
//  Created by xiaoo_gan on 12/23/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameScene.h"
@interface Projectile : NSObject

@property (nonatomic, strong) SKEmitterNode *emitter;
@property (nonatomic, strong) SKSpriteNode *node;
@property (nonatomic, strong) UIColor *color;

- (id) initWithPosition:(SpawnPoint *) point;

@end
