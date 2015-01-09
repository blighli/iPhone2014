//
//  SpawnPoint.m
//  FissureGame
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "SpawnPoint.h"

#define CHECK_VALUE(_v) if (!dictionary[_v]) { NSLog(@"出墨点 丢失参数：%@", _v); }

@implementation SpawnPoint

@synthesize position;
@synthesize positionJitter;
@synthesize friction;
@synthesize frameInterval;
@synthesize initialVelocity;
@synthesize node;
@synthesize color;

- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize)sceneSize {
    if ((self = [super init])) {
        
        float offset = (sceneSize.width > 481) ? 44 : 0;
        sceneSize.width = 480;
        
        //发射点的位置
        position = CGPointMake([dictionary[@"px"] floatValue] * sceneSize.width + offset, [dictionary[@"py"] floatValue] * sceneSize.height);
        //发射源大小
        positionJitter = CGSizeMake([dictionary[@"jx"] floatValue] * sceneSize.width, [dictionary[@"jy"] floatValue] * sceneSize.height);
        
        friction = [dictionary[@"friction"] floatValue];
        frameInterval = [dictionary[@"frameInterval"] intValue];
        
        //角度方向
        float angle = [dictionary[@"angle"] floatValue];
        //速度大小
        float speed = [dictionary[@"speed"] floatValue] * sceneSize.width;
        //初始化x，y方向上的速率
        initialVelocity = CGVectorMake(cos(angle) * speed, sin(angle) * speed);
        NSDictionary *colorDic = dictionary[@"color"];
        color = [UIColor colorWithRed:[colorDic[@"r"] floatValue]/255.0
                                green:[colorDic[@"g"] floatValue]/255.0
                                 blue:[colorDic[@"b"] floatValue]/255.0
                                alpha:[colorDic[@"a"] floatValue]];
        
        //CHECK_VALUE(_v) 各个参数
        CHECK_VALUE(@"px");
        CHECK_VALUE(@"py");
        CHECK_VALUE(@"jx");
        CHECK_VALUE(@"jy");
        CHECK_VALUE(@"friction");
        CHECK_VALUE(@"frameInterval");
        CHECK_VALUE(@"angle");
        CHECK_VALUE(@"speed");
        
        frameCount = 1;
        
        //创建发射点
        node = [SKSpriteNode spriteNodeWithImageNamed:@"disc"];
        //设置透明度为0.1
        node.alpha = 0.1;
        //设置颜色
        node.color = color;
        //设置颜色混合因子 最大 = 1
        node.colorBlendFactor = 1;
        //设置发射点的大小
        node.size = CGSizeMake(MAX(positionJitter.width, positionJitter.height) + 5, MAX(positionJitter.width, positionJitter.height) + 5);
        //设置发射点的位置
        node.position = position;
    }
    return self;
}
- (BOOL) shouldSpawnThisFrame {
    frameCount ++;
    if (frameCount > frameInterval) {
        frameCount = 1;
        return YES;
    }
    return NO;
}
@end
