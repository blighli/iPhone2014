//
//  GameScene.m
//  FissureGame
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "GameScene.h"

#define SCALE_RADIUS_WIDTH 20


//矢量长度
static inline float rwLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

@implementation GameScene

@synthesize spawnPoints;
@synthesize controls;
@synthesize targets;
@synthesize fissures;
@synthesize staticImages;


- (id) initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];//设置背景颜色
        self.physicsWorld.gravity = CGVectorMake(0, 0); //设置物理世界的重力感应为0
        self.physicsWorld.contactDelegate = self;       //将场景设置为物理世界的代理 (当有两个物体碰撞时，会收到通知)
        spawnPoints = [NSMutableArray array];           //创建发射点对象数组
        controls = [NSMutableArray array];              //创建控制器对象数组
        targets = [NSMutableArray array];               //创建转盘对象数组
        fissures = [NSMutableArray array];              //创建发射物对象对象数组
        staticImages = [NSMutableArray array];          //创建静态图片对象数组
        
        lastFrameTime = 0;                              //初始化上一帧时间
        
        //创建视图边界范围
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectInset(self.frame, -150, -100)];
        //标记视图边沿
        self.physicsBody.categoryBitMask = PHYS_CAT_EDGE;
        
    }
    return self;
}
- (void) initBackground:(NSDictionary *) dictionary {
    float r = [dictionary[@"r"] floatValue];
    float g = [dictionary[@"g"] floatValue];
    float b = [dictionary[@"b"] floatValue];
    float a = [dictionary[@"g"] floatValue];
    self.backgroundColor = [SKColor colorWithRed:r/255.0
                                           green:g/255.0
                                            blue:b/255.0
                                           alpha:a];          //设置背景颜色
    
}
////加载地图数据
- (void) loadFromLevelDictionary:(NSDictionary *)level {
    CGSize screenSize = self.size;
    
    //加载教程图片
//    for (NSDictionary *staticDic in level[@"static"]) {
//        NSString *image = staticDic[@"image"];
//        SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:image];
//        node.alpha = 0;
//        [self addChild:node];
//        node.position = CGPointMake(self.size.width / 2, self.size.height / 2);
//        [node animateToAlpha:0.65 delay:1.5 duration:1.5];
//        [staticImages addObject:node];
//    }
    
    projectileParticleLayerNode = [SKNode node];
    projectileParticleLayerNode.position = CGPointMake(50, 200);
    [self addChild:projectileParticleLayerNode];
    
    projectileLayerNode = [SKNode node];
    projectileLayerNode.zPosition = 0.5;
    [self addChild:projectileLayerNode];
    
    projectileParticleLayerNode.alpha = 1;
    projectileLayerNode.alpha = 1;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   ^{
                       shouldSpawnProjectile = YES;     //设置可以发射发射物
                    });
    
//  初始化场景颜色与背景
    NSArray *sceneDic = level[@"scene"];
    for (NSDictionary *dic in sceneDic) {
        [self initBackground:dic];
    }
    NSArray *spawnDics = level[@"spawns"];              //加载发射点
    int spawnIndex = 0;                                 //发射点id
                                                        //显示发射点
    for (NSDictionary *dic in spawnDics) {
        SpawnPoint *spawn = [[SpawnPoint alloc] initWithDictionary:dic
                                                    forSceneSize:screenSize]; //初始化发射点
        [spawnPoints addObject:spawn];                  //添加到当前发射点对象数组
        NSLog(@"在点（%.2f, %.2f）添加发射点：%d",  spawn.position.x, spawn.position.y, spawnIndex);
        [self addChild:spawn.node];                     //添加发射到视图
        float delay = 0.1 + (spawnIndex * 0.25);        //显示延迟时间
        spawn.node.alpha = 0;                           //显示动画
        [spawn.node bounceInAfterDelay:delay duration:0.9 bounces:5];
        [spawn.node animateToAlpha:0.1 delay:delay duration:0.4];
        spawnIndex ++;
    }
    
    NSArray *controlDics = level[@"controls"];          //从选择地图中获得控制器数组对象
    NSMutableArray *warps = [NSMutableArray array];     //虫洞控制器数组
    int controlIndex = 0;                               //控制器id
    for (NSDictionary *dic in controlDics) {            //将控制器添加到当前地图中去
        if ([dic[@"ignore"] boolValue]) {
            continue;
        }
        //创建控制器
        GameControl *control = [[GameControl alloc] initWithDictionary:dic
                                                          forSceneSize:screenSize];
        //设置控制器的场景为当前
        control.scene = self;
        //添加控制器到对象数组中
        [controls addObject:control];
        NSLog(@"在点（%.2f, %.2f）添加控制器%d：%d", control.position.x, control.position.y,
                                                    control.controlType, controlIndex);
       
        //在地图上，添加控制器
        if (control.node) {//节点
            [self addChild:control.node];
        }
        if (control.icon) {//图标
            [self addChild:control.icon];
        }
        if (control.shape) {//范围形状
            [self addChild:control.shape];
        }
        //如果该控制器为虫洞控制器，则加入虫洞控制器数组
        if (control.controlType == CONTROL_TYPE_WARP) {
            [warps addObject:control];
        }
        
        //显示延迟时间
        float delay = 0.1 + (controlIndex * 0.1);
        //透明度设置为0
        control.node.alpha = 0;
        control.icon.alpha = 0;
        control.shape.alpha = 0;
        
        //设置显示动画效果
        [control.node bounceInAfterDelay:delay duration:0.9 bounces:5];
        if (control.controlType != CONTROL_TYPE_SHAPE) {
            [control.node animateToAlpha:0.5 delay:delay duration:0.4];
        }
        [control.icon bounceInAfterDelay:delay duration:0.9 bounces:5];
        [control.icon animateToAlpha:0.8 delay:delay duration:0.4];
        [control.shape bounceInAfterDelay:delay duration:0.9 bounces:5];
        [control.shape animateToAlpha:1 delay:delay duration:0.4];
        
        controlIndex ++;
    }
    
    //加载粒子源
    NSArray *fissureDics = level[@"fissures"];
    int fissureIndex = 1;
    for (NSDictionary *dic in fissureDics) {
        Fissure *fissure = [[Fissure alloc] initWithDictionary:dic
                                                  forSceneSize:screenSize];
        fissure.fissureIndex = fissureIndex;                //设置id
        [fissures addObject:fissure];                       //添加到当前粒子源数组
        NSLog(@"在点（%.2f, %.2f）加载粒子源 %d", fissure.position.x, fissure.position.y, fissureIndex);
        [self addChild:fissure];                            //添加粒子源到视图
        float delay = 0.25 + (fissureIndex * 0.25);         //显示延迟时间
        fissure.alpha = 0;                                  //初始化 透明度 ＝ 0
        [fissure animateToAlpha:1 delay:delay duration:1.5];//动画显示
        fissureIndex ++;                                    //粒子源id ＋1
    }
    
    //加载转盘
    NSArray *targetDics = level[@"targets"];
    int targetIndex = 0;
    for (NSDictionary *dic in targetDics) {
        Target *target = [[Target alloc] initWithDictionary:dic
                                               forSceneSize:screenSize];
        //如果地图中存在非黑色的粒子源，则设置转盘相对应的粒子源的颜色
        if (target.matchedFissure) {
            target.color = ((Fissure *) fissures[target.matchedFissure - 1]).color;
        } else {
            target.color = [spawnPoints[0] color];
        }
        
        //将转盘添加到当前转盘数组
        [targets addObject:target];
        NSLog(@"在点（%.2f, %.2f）加载转盘 %d", target.position.x, target.position.y, targetIndex);
        //将转盘添加到当前地图上
        [self addChild:target.node];
        
        //动画显示转盘
        float delay = 0.1 + (targetIndex * 0.15);
        target.node.alpha = 0;
        [target.node bounceInAfterDelay:delay duration:0.9 bounces:5];
        [target.node animateToAlpha:1 delay:delay duration:0.4];
        
        targetIndex ++;
    }
    

    //连接虫洞区域
    if ([warps count]== 0) {
        NSLog(@"没有虫洞区域");
    } else if ([warps count] % 2 == 0) {    //虫洞个数为偶数
        for (int i = 0; i < [warps count]; i += 2) {
            GameControl *w1 = warps[i];
            GameControl *w2 = warps[i + 1];
            w1.connectedWarp = w2;
            w2.connectedWarp = w1;
        }
    } else {
        NSLog(@"虫洞个数无效: %d", (int) [warps count]);
    }
    
    //容许全触发
    canTriggerFull = YES;
}


//因为选择了新的关卡，强制进入选择的关卡
- (void) forceWin {
    [self allTargetsFull];
}

- (void) allTargetsFull {
    if (!canTriggerFull) {
        return;
    }
    canTriggerFull = NO;
    //GameViewController 中代理的方法
    [self.sceneDelegate sceneAllTargetsLit];
    
    [self levelOverStageOne];
}
// 转换场景：阶段一  在场景隐藏所有对象
- (void) levelOverStageOne {
    
//    //首先显示静态图片
//    for (SKNode *node in staticImages) {
//        [node animateToAlpha:0 delay:0 duration:0.5];
//    }
    
    //动画隐藏控制器
    int controlIndex = 0;
    for (GameControl *mControl in controls) {
        float delay = 0.5 + controlIndex * 0.15;
        [mControl.node bounceInAfterDelay:delay - 0.25 duration:0.9 bounces:2];
        [mControl.icon bounceInAfterDelay:delay - 0.25 duration:0.9 bounces:2];
        [mControl.shape bounceInAfterDelay:delay - 0.25 duration:0.9 bounces:2];
        [mControl.node animateToAlpha:0 delay:delay duration:0.5];
        [mControl.icon animateToAlpha:0 delay:delay duration:0.5];
        [mControl.shape animateToAlpha:0 delay:delay duration:0.5];
        controlIndex ++;
    }
    //动画隐藏发射物图层
    [projectileLayerNode animateToAlpha:0 delay:0 duration:0.75];
    [projectileParticleLayerNode animateToAlpha:0 delay:0 duration:0.75];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       //不再发射发射物
                       shouldSpawnProjectile = NO;
                   });
    
    //动画隐藏转盘
    int targetIndex = 0;
    for (Target *target in targets) {
        float delay = 1 + targetIndex * 0.15;
        [target.node animateToAlpha:0 delay:delay duration:0.5];
        [target.node animateToScale:0.5 delay:delay duration:0.5];
        targetIndex ++;
    }
    
    //动画隐藏粒子源
    int fissureIndex = 0;
    for (Fissure * fissure in fissures) {
        float delay = 1 + fissureIndex * 0.15;
        [fissure animateToAlpha:0 delay:delay duration:0.5];
        [fissure animateToScale:0.5 delay:delay duration:0.5];
        fissureIndex ++;
    }
    
    //动画隐藏发射源
    int spawnIndex = 0;
    for (SpawnPoint * spawn in spawnPoints) {
        float delay = 1 + spawnIndex * 0.15;
        [spawn.node animateToAlpha:0 delay:delay duration:0.5];
        [spawn.node animateToScale:0.5 delay:delay duration:0.5];
        spawnIndex ++;
    }
    //进入 第二阶段
    [self performSelector:@selector(levelOverStageTwo)
               withObject:nil
               afterDelay:2];
}

// 转换场景：阶段二  在场景移除所有对象
- (void) levelOverStageTwo {
    
//    for (SKNode *node in staticImages) {
//        [node removeFromParent];
//    }
//    [staticImages removeAllObjects];
    //移除控制器
    for (GameControl *control in controls) {
        [control.node removeFromParent];
        [control.icon removeFromParent];
        [control.shape removeFromParent];
    }
    [controls removeAllObjects];
    
    //移除粒子源
    for (Fissure *fissure in fissures) {
        [fissure removeFromParent];
    }
    [fissures removeAllObjects];
    
    //移除发射源
    for (SpawnPoint *spawnPoint in spawnPoints) {
        [spawnPoint.node removeFromParent];
    }
    [spawnPoints removeAllObjects];
    
    //移除转盘
    for (Target *target in targets) {
        [target.node removeFromParent];
    }
    [targets removeAllObjects];
    
    //移除发射物图层
    [projectileLayerNode removeFromParent];
    [projectileParticleLayerNode removeFromParent];
    
    projectileLayerNode =nil;
    projectileParticleLayerNode = nil;
    
    //延迟自动进入第三阶段
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [self levelOverStageThree];
                        });
}
// 转换场景：阶段三
- (void) levelOverStageThree {
    [self.sceneDelegate sceneReadyToTransition];
}


- (void) removeNodeFromAllControlsNotInRange:(SKNode *)node {
    
    for (GameControl *mControl in controls) {
        if (mControl.controlType == CONTROL_TYPE_WARP) {
            continue;
        }
        float dx = node.position.x - mControl.position.x;
        float dy = node.position.y - mControl.position.y;
        float dist = sqrt(dx * dx + dy * dy);
        if (dist > mControl.radius) {
            [mControl.affectedProjectiles removeObjectIdenticalTo:node];
        }
    }
}

//重置转盘的位置
- (void) resetControlsToInitialPositions {
    for (GameControl *mControl in controls) {
        
        [mControl.node bounceToPosition:mControl.initialPosition scale:1 delay:0 duration:1.1 bounces:5];
        [mControl.icon bounceToPosition:mControl.initialPosition scale:1 delay:0 duration:1.1 bounces:5];
        [mControl.shape bounceToPosition:mControl.initialPosition scale:1 delay:0 duration:1.1 bounces:5];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                            mControl.position = mControl.initialPosition;
                            mControl.radius = mControl.initialRadius;
                            });
    }
}
//发射发射物
- (void) spawnProjectiles {
    
    if (!shouldSpawnProjectile) {
        return;
    }
    
    for (SpawnPoint *point in spawnPoints) {
        if (![point shouldSpawnThisFrame]) {
            continue;
        }
        
        Projectile *proj = [[Projectile alloc] initWithPosition:point];
        [projectileLayerNode addChild:proj.node];
        proj.emitter.targetNode = projectileParticleLayerNode;
    }
}

- (void) update:(NSTimeInterval)currentTime {

    //上一帧和现在的时间间隔
    CFTimeInterval elapsedTime = currentTime - lastFrameTime;
    lastFrameTime = currentTime;                        //设置上一帧时间为目前时间
    
    if (elapsedTime > 1) {                              //初始时，lastFrameTime ＝ 0，故elapsedTime > 1
        return;
    }
    [self spawnProjectiles];                            //发射发射物
    
    //控制器
    for (GameControl *control in controls) {
        [control updateAffectedProjectilesForDuration:elapsedTime];
    }
    
    BOOL allFull = YES;
    for (Target *target in targets) {
        [target updateForDuration:elapsedTime];
        //饱和后的滞后时间都达到 （规定的滞后时间 ＋ 0.25）
        if (target.timeFull < (target.hysteresis + 0.25)) {
            allFull = NO;
        }
    }
    //所有进度完成，进入下一关卡
    if (allFull) {
        [self allTargetsFull];
    }
    //移除速度低的发射物
    for (SKNode *node in projectileLayerNode.children) {
        float dx = node.physicsBody.velocity.dx;
        float dy = node.physicsBody.velocity.dy;
        
        if(dx < 10 && dy < 10 && dx > -10 && dy > -10) {
            BOOL found = NO;
            for (GameControl *control in controls) {
                if ([control.affectedProjectiles indexOfObjectIdenticalTo:node] != NSNotFound) {
                    found = YES;
                    break;
                }
            }
            
            if (!found) {
                [node removeFromParent];
            }
        }
    }
}

#pragma mark - Contact Checks

//发生碰撞，处理方法
- (void) didBeginContact:(SKPhysicsContact *)contact {
    
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & PHYS_CAT_EDGE)
            && (secondBody.categoryBitMask & PHYS_CAT_PROJ)) {
        if (secondBody.node == nil) {
            return;
        }
        [projectileLayerNode removeChildrenInArray:@[secondBody.node]];
        return;
    }
    if (firstBody.categoryBitMask & PHYS_CAT_PROJ) {
        
        if (secondBody.categoryBitMask & PHYS_CAT_CONTROL_TRANS) {
            GameControl *control = secondBody.node.userData[@"control"];
            //if (firstBody.node) {
                [control.affectedProjectiles addObject:firstBody.node];
           // }
            return;
        }
        
        if (secondBody.categoryBitMask & PHYS_CAT_TARGET) {
            
            Target *target = secondBody.node.userData[@"target"];
            
            SKSpriteNode *proj = (SKSpriteNode *) firstBody.node;
            //颜色匹配
            if ([proj.userData[@"fissureIndex"] intValue] == target.matchedFissure) {
                [target hitByProjectile];
            }
            return;
        }
        
        //撞到形状障碍物，改变发射物的发射方向
        if (secondBody.categoryBitMask & PHYS_CAT_CONTROL_COLL) {
            SKSpriteNode *proj = (SKSpriteNode *) firstBody.node;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                         (int64_t)(0.0001 * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{
                                                proj.zRotation = atan2(proj.physicsBody.velocity.dy,
                                                                       proj.physicsBody.velocity.dx);
                                                        });
            return;
        }
        
    }
}

- (void) didEndContact:(SKPhysicsContact *)contact {
    SKPhysicsBody *firstBody, *secondBody;
    //将碰撞节点排序，以便于处理
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    //发射物是否撞到可穿过的控制器
    if (firstBody.categoryBitMask & PHYS_CAT_PROJ) { //发射物
        
        //可穿过的控制器
        if (secondBody.categoryBitMask & PHYS_CAT_CONTROL_TRANS) {
            GameControl *control = secondBody.node.userData[@"control"];
            [control.affectedProjectiles removeObjectIdenticalTo:firstBody.node];
            //虫洞控制器
            if (control.controlType == CONTROL_TYPE_WARP) {
                [firstBody.node.userData removeObjectForKey:@"warped"];
            }
            return;
        }
        
        //粒子源
        if (secondBody.categoryBitMask & PHYS_CAT_FISSURE) {
            Fissure *fissure = (Fissure *) secondBody.node;
            SKSpriteNode *proj = (SKSpriteNode *) firstBody.node;
            proj.color = fissure.color;
            proj.colorBlendFactor = 0.95;
            proj.userData[@"fissureIndex"] = @(fissure.fissureIndex);
            
            SKEmitterNode *emitter = (SKEmitterNode *) proj.userData[@"emitter"];
            CGFloat r, g, b, a;
            [fissure.color getRed:&r green:&g blue:&b alpha:&a];
            emitter.particleColorSequence = [[SKKeyframeSequence alloc] initWithKeyframeValues:
                                                                            @[[UIColor colorWithRed:r green:g blue:b alpha:0.15],
                                                                              [UIColor colorWithRed:r green:g blue:b alpha:0]]
                                                                                         times:@[@(0), @(1)]];
            return;
        }
    }
}


#pragma mark - Touch Controls

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //只响应单点触摸
    if ([touches count] == 1) {
        
        CGPoint touchPoint = [[touches anyObject] locationInNode:self];
        NSArray *touchedNodes = [self nodesAtPoint:touchPoint];
        NSLog(@"触摸点  x: %.3f y: %.3f", touchPoint.x / self.size.width, touchPoint.y / self.size.height);
        NSMutableArray *touchedControls = [NSMutableArray array];
        for (SKNode *mNode in touchedNodes) {
            if (![mNode.userData[@"isControl"] boolValue]) {    //如果不是控制器
                continue;
            }
            
            GameControl *mControl = mNode.userData[@"control"]; //获得控制器
            if (!mControl.canMove && !mControl.canScale) {      //如果控制器不可移动，且不可缩放比例
                continue;
            }
            [touchedControls addObject:mControl];               //添加到触摸控制器数组
        }
        if (![touchedControls count]) {                         //没有触摸到控制器，直接返回
            return;
        }
        
        draggedControl = nil;
        float minDist = 1000000;
        for (GameControl *control in touchedControls) {
                                                                //偏移矢量
            CGPoint offset = CGPointMake(control.position.x - touchPoint.x,
                                         control.position.y - touchPoint.y);
            float dist = rwLength(offset);                      //偏移量长度
            if (dist < minDist) {
                minDist = dist;                                 //控制器中心点到触摸点的距离
                draggedControl = control;                       //初始设置为移动控制器
                dragOffset = offset;                            //控制器中心到初始触摸点的偏移矢量
            }
        }
        if (!draggedControl.canScale) {                         //如果控制器不能缩放，则返回
            return;
        }
        
        //通过计算触摸点和控制器中心的距离， 判断是移动控制器，还是缩放控制器
        //如果触摸点在控制器到边缘距离 < 20 , 则表示时缩放控制器
        if (minDist > ((draggedControl.radius) - SCALE_RADIUS_WIDTH)) {
            scalingControl = draggedControl;                    //设置当前触摸的控制器为缩放控制器
            draggedControl = nil;                               //取消移动控制器的设置
            scalingOffset = scalingControl.radius - minDist;    //初始触摸点到空间边界的距离
        } else if(!draggedControl.canMove) {                    //如果控制器不能移动
            draggedControl = nil;
        }
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([touches count] > 1) {                                  //多点触摸，不响应
        return;
    }
                                                                //获得触摸位置坐标
    CGPoint touchPoint = [[touches anyObject] locationInNode:self];
    if (draggedControl) {                                       //移动控制器
                                                                //设置控制器的新位置
    
        draggedControl.position = CGPointMake(touchPoint.x + dragOffset.x,
                                              touchPoint.y + dragOffset.y);
        [self resetTargetTimers];
    } else if (scalingControl) {                                //缩放控制器
                                                                //移动中，控制器中心到此时触摸点的偏移矢量
        CGPoint offset = CGPointMake(touchPoint.x - scalingControl.position.x,
                                     touchPoint.y - scalingControl.position.y);
        float dist = rwLength(offset);                          //移动中，控制器中心到此时触摸点的偏移距离
        float radius = dist + scalingOffset;                    //半径长度
        scalingControl.radius = radius;                         //设置新的半径
        [self resetTargetTimers];
    }
}

//触摸结束
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    scalingControl = nil;
    draggedControl = nil;
}

- (void) resetTargetTimers {
    for (Target *target in targets) {
        [target controlMoved];
    }
}
@end
