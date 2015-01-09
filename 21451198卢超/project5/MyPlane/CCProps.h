//
//  CCProps.h
//  MyPlane
//
//  Created by jiaoshoujie on 14-12-12.
//  Copyright (c) 2014年 jiaoshoujie. All rights reserved.
//

#import <Foundation/Foundation.h>
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
