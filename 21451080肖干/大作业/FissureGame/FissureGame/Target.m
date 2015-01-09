//
//  Target.m
//  FissureGame
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "Target.h"

#define CHECK_VALUE(_v) if (!dictionary[_v]) { EXLog(MODEL, WARN, @"Target字典缺失参数： %@", _v ); }

#define TARGET_RADIUS       20      //转盘半径
#define DIALS_PER_TARGET    7       //每个转盘的零件个数
#define NUM_DIAL_IMAGES     7       //转盘零件图像


@implementation Target

@synthesize position;
@synthesize matchedFissure;
@synthesize progress;
@synthesize hysteresis;
@synthesize progressPerHit;
@synthesize lossPerTime;
@synthesize lastHitTime;
@synthesize dials;
@synthesize node;
@synthesize currentTime;
@synthesize timeFull;
@synthesize color;

- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize)sceneSize {
    
    if ((self = [super init])) {
        float offset = (sceneSize.width > 481) ? 44 : 0;
        sceneSize.width = 480;
        
        position = CGPointMake([dictionary[@"px"] floatValue] * sceneSize.width + offset, [dictionary[@"py"] floatValue] *sceneSize.height);    //转盘位置
        matchedFissure = [dictionary[@"matchedFissure"] intValue];      //匹配粒子源的id
        
        CHECK_VALUE(@"px");
        CHECK_VALUE(@"py");
        CHECK_VALUE(@"matchedFissure");
        
        //初始化各参数
        progress = 0;               //初始化，进度
        hysteresis = 1;             //滞后时间
        progressPerHit = 0.5;       //每被击中一次，所完成的进度
        lastHitTime = 0;            //上次被击中的时间
        lossPerTime = 0.6;          //丢失进度率
        
        //转盘数组
        dials = [NSMutableArray array];
        
        //为这个转盘创建节点
        node = [SKNode node];
        node.position = position;
        node.userData = [NSMutableDictionary dictionaryWithDictionary:@{@"isTarget":@(YES),
                                                                        @"target":self}];
        node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:TARGET_RADIUS];
        node.physicsBody.dynamic = YES;
        node.physicsBody.categoryBitMask = PHYS_CAT_TARGET; //标记为转盘
        node.physicsBody.collisionBitMask = 0;
        node.physicsBody.contactTestBitMask = 0;
        node.physicsBody.friction = 0;
        
        // 创建转盘 7个转盘零件
        static float dial_factor[DIALS_PER_TARGET] = {1, 0.8, 1, 0.4, 1, 0.6, 1 };
        for (int i = 0; i < DIALS_PER_TARGET; i ++) {
            //初始化dial精灵
            SKSpriteNode *dial = [SKSpriteNode spriteNodeWithImageNamed:[NSString stringWithFormat:@"activity_disc_%d", i]];
            //坐标为（0，0）
            dial.position = CGPointZero;
            //设置颜色 黑色
            dial.color = [UIColor blackColor];
            //设置颜色混合因子 最大
            dial.colorBlendFactor = 1;
            //设置透明度
            dial.alpha = 0.15;
            //设置大小
            dial.size = CGSizeMake(TARGET_RADIUS * 2 * dial_factor[i], TARGET_RADIUS * 2 * dial_factor[i]);
            //初始旋转角度
            dial.zRotation = rand() % 1000 / 1000.0 * 2 * M_PI;
            //为dial设置对应的物体，此处设置为圆形
            dial.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:TARGET_RADIUS];
            //物理引擎不再控制这个dial的运动，因为已经写好dial运动的代码了
            dial.physicsBody.dynamic = YES;
            dial.physicsBody.categoryBitMask = 0;
            //在此我们不希望和dial碰撞相互弹开，故设置为0
            dial.physicsBody.collisionBitMask = 0;
            dial.physicsBody.contactTestBitMask = 0;
            dial.physicsBody.angularVelocity = 0;
            dial.physicsBody.affectedByGravity = NO;
            dial.physicsBody.friction = 0;
            dial.physicsBody.angularDamping = 0;
            
            //将该转盘零件添加到该转盘
            [node addChild:dial];
            //添加该转盘到数组
            [dials addObject:dial];
        }
    }
    return self;
}

//设置转盘颜色
- (void) setColor:(UIColor *)mColor {
    color = mColor;
    //为每个小零件设置颜色
    for (SKSpriteNode *dial in dials) {
        dial.color = color;
        dial.alpha = 0.4;
    }
}


- (void) hitByProjectile {
    //被发射物持续击中累计时间
    accelToTime = currentTime + 0.1;
}


- (void) updateForDuration:(CFTimeInterval)duration {
    currentTime += duration;
    //是否被击中？
    if (currentTime < accelToTime) {
        lastHitTime = currentTime;
        
        if (progress < 1) { //当前进度未满
            progress += progressPerHit * duration;
            if (progress > 1) { //progress 已满
                progress = 1;
            }
        }
    }
    
    if (progress >= 1) {
        //进度饱和后，滞后时间
        timeFull += duration;
    } else {
        //进度未完成，滞后时间 至0
        timeFull = 0;
    }
    //如果进度 <= 0 表示已停止运动
    if (progress <= 0) {
        return;
    }
    CFTimeInterval sinceLastHit = currentTime - lastHitTime;
    if (sinceLastHit > hysteresis) { //规定滞后时间内 未击中，减少累计进度
        progress -= (duration * lossPerTime);
    }
    [self updateDialSpeed];          //调整转盘旋转速度
}


//转盘旋转速度
- (void) updateDialSpeed {
    int i = 0;
    for (SKSpriteNode *dial in dials) {
        dial.physicsBody.angularVelocity = 4 * ((i < 3) ? 1 : -1) * (float)(i + 2)
                                              / DIALS_PER_TARGET * progress;
        i ++;
    }
}


//控制器移动后，则累计滞后时间归零
- (void) controlMoved {
    timeFull = 0;
}

@end






















