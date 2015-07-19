//
//  GameScene.h
//  FissureGame
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "GameControl.h"
#import "SpawnPoint.h"
#import "Projectile.h"
#import "Fissure.h"
#import "Target.h"

#define PHYS_CAT_EDGE               0x0001
#define PHYS_CAT_PROJ               0x0002      //发射物
#define PHYS_CAT_TARGET             0x0004      //转盘
#define PHYS_CAT_FISSURE            0x0008      //粒子源

#define PHYS_CAT_CONTROL_TRANS      0x0100      //可穿过控制器
#define PHYS_CAT_CONTROL_COLL       0x0200      //障碍物

#define PROJECTILE_PHYS_RADIUS      3

//代理
@protocol GameSceneDelegate <NSObject>
- (void) sceneAllTargetsLit;
- (void) sceneReadyToTransition;
@end

@interface GameScene : SKScene <SKPhysicsContactDelegate> {
    //上一帧出现的时间点
    CFTimeInterval lastFrameTime;
    //发射物粒子尾迹
    SKNode *projectileParticleLayerNode;
    
    SKNode *projectileLayerNode;
    
    //正在拖拽的控制器
    GameControl *draggedControl;
    CGPoint dragOffset;
    //正在缩放的控制器
    GameControl *scalingControl;
    float scalingOffset;
    
    //判断是否触发最大化
    BOOL canTriggerFull;
    
    //是否发射发射物
    BOOL shouldSpawnProjectile;
    
}

@property (nonatomic, readonly) NSMutableArray *spawnPoints;
@property (nonatomic, readonly) NSMutableArray *controls;
@property (nonatomic, readonly) NSMutableArray *targets;
@property (nonatomic, readonly) NSMutableArray *fissures;
@property (nonatomic, readonly) NSMutableArray *staticImages;

@property (nonatomic, weak) id<GameSceneDelegate> sceneDelegate;

- (void) loadFromLevelDictionary: (NSDictionary *)level;
- (void) removeNodeFromAllControlsNotInRange:(SKNode *)node;
- (void) resetControlsToInitialPositions;
- (void) levelOverStageOne;
- (void) forceWin;

@end
