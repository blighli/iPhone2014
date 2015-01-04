//
//  CCFoePlane.h
//  AirPlane
//
//  Created by JANESTAR on 14-12-15.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import "CCSprite.h"

@interface CCFoePlane : CCSprite
@property (readwrite) int planeType;
@property (readwrite) int hp;
@property (readwrite) int speed;
@property (readwrite) int bulletspeed2;
@property(nonatomic,strong) CCSprite* bullet2;

@end
