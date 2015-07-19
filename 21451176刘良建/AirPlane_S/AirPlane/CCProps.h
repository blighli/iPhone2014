//
//  CCProps.h
//  AirPlane
//
//  Created by JANESTAR on 14-12-15.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import "CCNode.h"
#import "cocos2d.h"
typedef enum {
    propsTypeBomb = 4,
    propsTypeBullet = 5
}propsType;

@interface CCProps : CCNode

@property (assign) CCSprite *prop;
@property (assign) propsType type;
- (void) initWithType:(propsType)type;
- (void) propAnimation;


@end
