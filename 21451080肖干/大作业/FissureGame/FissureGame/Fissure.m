//
//  Fissure.m
//  FissureGame
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "Fissure.h"

#define CHECK_VALUE(_v) if (!dictionary[_v]) { NSLog(@"粒子源字典缺失参数：%@",_v); }

@implementation Fissure

@synthesize color;

- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize)sceneSize {
    if ((self = [super init])) {
        
        //设置粒子源位置
        float offset = (sceneSize.width > 481) ? 44 : 0;
        sceneSize.width = 480;
        self.position = CGPointMake([dictionary[@"px"] floatValue] * sceneSize.width + offset,
                                    [dictionary[@"py"] floatValue] * sceneSize.height);
        //读取半径
        float radius = [dictionary[@"radius"] floatValue] * sceneSize.width;
        //读取颜色
        NSDictionary *colorDic = dictionary[@"color"];
        color = [UIColor colorWithRed:[colorDic[@"r"] floatValue]
                                green:[colorDic[@"g"] floatValue]
                                 blue:[colorDic[@"b"] floatValue]
                                alpha:[colorDic[@"a"] floatValue]];
        
        CHECK_VALUE(@"px");
        CHECK_VALUE(@"py");
        CHECK_VALUE(@"radius");
        CHECK_VALUE(@"color");
        
        //设置在z轴上的位置
        self.zPosition = 1;
        //设置与该粒子源相同大小的物体，为圆形
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
        //物理引擎不再控制这个粒子源的运动，因为已经写好相应的代码
        self.physicsBody.dynamic =YES;
        self.physicsBody.categoryBitMask = PHYS_CAT_FISSURE;    //编号
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = 0;
        self.physicsBody.friction = 0;
        
        //设置粒子发射器
        SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]
                                                                             pathForResource:@"fissure"
                                                                             ofType:@"sks"]];
        //设置粒子发射器颜色序列
        emitter.particleColorSequence = [self sequenceForColor:color];
        
        //添加到粒子源对象
        [self addChild:emitter];
    }
    return self;
}
//粒子发射器颜色序列
- (SKKeyframeSequence *) sequenceForColor:(UIColor *) mColor {
    
    CGFloat r, g, b,a;
    [mColor getRed:&r green:&g blue:&b alpha:&a];
    return [[SKKeyframeSequence alloc]
            initWithKeyframeValues:@[[UIColor colorWithRed:r green:g blue:b alpha:0.5],
                                     [UIColor colorWithWhite:0.4 alpha:0]]
                             times:@[@(0), @(1)]];
}
@end













