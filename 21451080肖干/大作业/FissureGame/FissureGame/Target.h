//
//  Target.h
//  FissureGame
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameScene.h"
@interface Target : NSObject {
    CFTimeInterval accelToTime;
}
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) float progress;
@property (nonatomic, readonly) float hysteresis;
@property (nonatomic, readonly) float progressPerHit;
@property (nonatomic, readonly) CFTimeInterval currentTime;
@property (nonatomic, readonly) CFTimeInterval lastHitTime;
@property (nonatomic, readonly) CFTimeInterval timeFull;
@property (nonatomic, readonly) float lossPerTime;
@property (nonatomic, readonly) int matchedFissure;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong, readonly) NSMutableArray *dials;
@property (nonatomic, strong, readonly) SKNode *node;

- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize) sceneSize;
- (void) hitByProjectile;
- (void) updateForDuration:(CFTimeInterval) duration;
- (void) controlMoved;

@end
