//
//  Fissure.h
//  FissureGame
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
@interface Fissure : SKNode

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) int fissureIndex;

- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize) sceneSize;

@end
