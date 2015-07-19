//
//  SKFoePlane.h
//  weixinPlayPlane
//
//  Created by Chencheng on 14/12/12.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(int, SKFoePlaneType) {
    
    SKFoePlaneTypeBig = 1,
    SKFoePlaneTypeMedium = 2,
    SKFoePlaneTypeSmall = 3
};

@interface SKFoePlane : SKSpriteNode

@property (nonatomic,assign) int hp;
@property (nonatomic,assign) SKFoePlaneType type;


+ (instancetype)createBigPlane;

+ (instancetype)createMediumPlane;

+ (instancetype)createSmallPlane;

@end
