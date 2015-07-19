//
//  GameControl.h
//  FissureGame
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>


@class GameScene;

typedef enum ControlType {
    CONTROL_TYPE_PUSH   = 0,
    CONTROL_TYPE_GRAVITY ,
    CONTROL_TYPE_REPEL,
    CONTROL_TYPE_PROPEL,
    CONTROL_TYPE_SLOW,
    CONTROL_TYPE_WARP,
    CONTROL_TYPE_SHAPE,
    NUM_CONTROL_TYPES,
} ControlType_t;

@interface GameControl : NSObject {
    
}

@property (nonatomic, assign) ControlType_t controlType;
@property (nonatomic,assign) float angle;
@property (nonatomic,assign) CGPoint position;
@property (nonatomic,assign) float minRadius;   //最小半径
@property (nonatomic,assign) float maxRadius;   //最大半径
@property (nonatomic,assign) float radius;      //半径
@property (nonatomic,assign) float power;       //力度
@property (nonatomic,assign) CGVector powerVector;  //力度方向

@property (nonatomic,assign) BOOL canScale;     //能否调节大小
@property (nonatomic,assign) BOOL canRotate;    //能否旋转
@property (nonatomic,assign) BOOL canMove;      //能否移动

@property (nonatomic, strong, readonly) SKSpriteNode *node;
@property (nonatomic, strong, readonly) SKSpriteNode *icon;
@property (nonatomic, strong, readonly) SKShapeNode *shape;
@property (nonatomic, strong, readonly)  NSMutableArray *affectedProjectiles;  //影响到的抛射物

@property (nonatomic, readonly) CGPoint initialPosition;     //初始位置
@property (nonatomic, readonly) float initialRadius;         //初始半径大小

@property (nonatomic, weak) GameControl *connectedWarp;
@property (nonatomic, weak) GameScene *scene;

- (id) initWithDictionary:(NSDictionary*)dictionary forSceneSize:(CGSize) sceneSize;
- (void) updateAffectedProjectilesForDuration:(CFTimeInterval) duration;
@end
