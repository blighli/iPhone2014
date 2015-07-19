//
//  GameControl.m
//  FissureGame
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "GameControl.h"
#import "GameScene.h"

#define CHECK_VALUE(_v) if (!dictionary[_v]) { NSLog(@"字典缺失参数：%@", _v); }

#define WARP_NODE_REDIUS_UNIT   28.4

static NSString *s_controlStrings[NUM_CONTROL_TYPES] = {
    @"push",
    @"gravity",
    @"repel",
    @"propel",
    @"slow",
    @"warp",
    @"shape",
};

@implementation GameControl

@synthesize controlType;
@synthesize angle;
@synthesize position;
@synthesize radius;
@synthesize maxRadius;
@synthesize minRadius;
@synthesize canMove;
@synthesize canRotate;
@synthesize canScale;
@synthesize connectedWarp;
@synthesize power;
@synthesize powerVector;
@synthesize initialPosition;
@synthesize initialRadius;
@synthesize affectedProjectiles;
@synthesize node;
@synthesize icon;
@synthesize shape;

//对各控制器进行初始化数据
- (id) initWithDictionary:(NSDictionary *)dictionary forSceneSize:(CGSize)sceneSize {
    if (self = [super init]) {
        float offset = (sceneSize.width > 481) ? 44 : 0;
        sceneSize.width = 480;
        controlType = [self controlTypeForString:dictionary[@"type"]];          //类型
        angle = [dictionary[@"angle"] floatValue];                              //角度
        position = CGPointMake([dictionary[@"px"] floatValue] *sceneSize.width + offset,
                               [dictionary[@"py"] floatValue] * sceneSize.height);//位置
        radius = [dictionary[@"radius"] floatValue] * sceneSize.width;          //半径
        minRadius = [dictionary[@"minRadiusScale"] floatValue] * radius;        //最小缩放比例
        maxRadius = [dictionary[@"maxRadiusScale"] floatValue] * radius;        //最大缩放比例
        canMove = [dictionary[@"canMove"] boolValue];                           //是否能移动
        canRotate = [dictionary[@"canRotate"] boolValue];                       //是否能旋转
        canScale = [dictionary[@"canScale"] boolValue];                         //是否能缩放
        power = [dictionary[@"power"] floatValue];                              //控制器施力大小
        powerVector = CGVectorMake(power * sceneSize.width * cos(angle),        //控制器施力方向矢量
                                   power * sceneSize.width * sin(angle));
        
        CHECK_VALUE(@"px");
        CHECK_VALUE(@"py");
        CHECK_VALUE(@"type");
        CHECK_VALUE(@"angle");
        CHECK_VALUE(@"radius");
        CHECK_VALUE(@"minRadiusScale");
        CHECK_VALUE(@"maxRadiusScale");
        CHECK_VALUE(@"canRotate");
        CHECK_VALUE(@"canMove");
        CHECK_VALUE(@"canScale");
        CHECK_VALUE(@"power");
        
        //初始半径和位置
        initialRadius = radius;
        initialPosition = position;
        
        affectedProjectiles = [NSMutableArray array];        //被影响的发射物数组
        
        //创建这个控制器精灵
        node = [SKSpriteNode spriteNodeWithImageNamed:@"disc"];
        //设置各个参数
        node.alpha = 1.0;
        node.color = [UIColor whiteColor];
        node.colorBlendFactor = 1;
        node.size = CGSizeMake(radius * 2 , radius * 2);
        node.position = position;
        node.userData = [NSMutableDictionary dictionaryWithDictionary:@{@"isControl":@(YES),
                                                                        @"control":self}];
        
        //为控制器设置对应的物理，设置为圆形
        node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
        node.physicsBody.friction = 0;
        node.physicsBody.dynamic = YES;
        //标记为可穿过
        node.physicsBody.categoryBitMask = PHYS_CAT_CONTROL_TRANS;
        
        node.physicsBody.collisionBitMask = 0;
        //当control与projectile发生碰撞时。发出通知给contactDelegate
        node.physicsBody.contactTestBitMask = PHYS_CAT_PROJ;
        
        //根据控制器的类型 创建控制器的图标
        switch (controlType) {
                
            //方向控制器
            case CONTROL_TYPE_PUSH:
                icon = [SKSpriteNode spriteNodeWithImageNamed:@"disc_push"];
                icon.color = [UIColor colorWithRed:255.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
                icon.zRotation = angle - (M_PI / 2);  //所指方向
                node.color = [UIColor colorWithRed:255.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:0.5];
                break;
                
            //加速控制器
            case CONTROL_TYPE_PROPEL:
                icon = [SKSpriteNode spriteNodeWithImageNamed:@"disc_propel"];
                icon.color = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:180.0/255.0 alpha:1.0];
                node.color = [UIColor colorWithRed:0 green:1 blue:0.4 alpha:0.5];
                break;
                
            //减速控制器
            case CONTROL_TYPE_SLOW:
                icon = [SKSpriteNode spriteNodeWithImageNamed:@"disc_slow"];
                icon.color = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:51.0/255.0 alpha:1.0];
                node.color = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:51.0/255.0 alpha:0.7];
                break;
                
            //引力控制器
            case CONTROL_TYPE_GRAVITY:
                icon = [SKSpriteNode spriteNodeWithImageNamed:@"disc_attract"];
                icon.color = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:153.0/255.0 alpha:1.0];
                icon.zRotation = angle - (M_PI / 2);      //方向
                node.color = [UIColor colorWithRed:1 green:0.5 blue:0 alpha:0.5];
                break;
                
            //互斥控制器
            case CONTROL_TYPE_REPEL:
                icon = [SKSpriteNode spriteNodeWithImageNamed:@"disc_repel"];
                icon.color = [UIColor colorWithRed:1.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
                icon.zRotation = M_PI / 2;      //方向
                node.color = [UIColor colorWithRed:1 green:0.4 blue:1 alpha:0.5];
                break;
                
            //虫洞控制器
            case CONTROL_TYPE_WARP: {
                node.color = [UIColor clearColor];
                // 加载粒子发射器
                SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"warp"
                                                                                                                    ofType:@"sks"]];
                emitter.particleScale *= (radius / WARP_NODE_REDIUS_UNIT);                      //粒子的平均缩放因子
                emitter.particleScaleSpeed *= (radius / WARP_NODE_REDIUS_UNIT);                 //粒子的缩放因子
                emitter.particleSpeedRange *= (radius / WARP_NODE_REDIUS_UNIT);                 //粒子的初始速度
                [node addChild:emitter];                                                        //添加到节点
            }
                break;
                
            //障碍物
            case CONTROL_TYPE_SHAPE: {
                node.alpha = 0.0;
                shape = [SKShapeNode node];
                
                NSArray *points = dictionary[@"points"];
                if (!points) {
                    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-radius, -radius, radius * 2, radius * 2)].CGPath;
                    shape.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
                } else {
                    BOOL first = YES;
                    UIBezierPath *path = [UIBezierPath bezierPath];
                    for (NSDictionary *point in points) {
                        float mAngle = [point[@"angle"] floatValue];
                        float mRadius = [point[@"radius"] floatValue];
                        
                        float px = cos(mAngle) * mRadius * radius;
                        float py = sin(mAngle) * mRadius * radius;
                        if(first) {
                            [path moveToPoint:CGPointMake(px, py)];
                            first = NO;
                        } else {
                            [path addLineToPoint:CGPointMake(px, py)];
                        }
                    }
                    [path closePath];
                    shape.path = path.CGPath;
                    shape.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path.CGPath];
                }
                
                //设置形状属性
                shape.zRotation = angle;
                shape.antialiased = YES;
                shape.fillColor = [UIColor colorWithWhite:0.5 alpha:0.7];
                shape.strokeColor = [UIColor colorWithWhite:0.5 alpha:0.7];
                shape.lineWidth = 1;
                shape.position = position;
                
                shape.physicsBody.friction = 0;
                shape.physicsBody.dynamic = YES;
                //标识障碍物
                shape.physicsBody.categoryBitMask = PHYS_CAT_CONTROL_COLL;
                shape.physicsBody.collisionBitMask = 0;
                shape.physicsBody.contactTestBitMask = 0;
                
                node.physicsBody.categoryBitMask = 0;
                node.physicsBody.contactTestBitMask = 0;
                node.physicsBody.collisionBitMask = 0;
            }
                break;
                
            default:
                break;
        }
        
        if (icon) {
            icon.colorBlendFactor = 1;
            icon.position = position;
        }
    }
    return self;
}

// 控制器类型的字符
- (ControlType_t) controlTypeForString:(NSString *)cString {
    for (int i = 0; i < NUM_CONTROL_TYPES; i ++) {
        if ([cString isEqualToString:s_controlStrings[i]]) {
            return i;
        }
    }
    NSLog(@"无效的控制器类型:%@", cString);
    return CONTROL_TYPE_PUSH;
}

//设置控制器的位置
- (void) setPosition:(CGPoint)mPosition {
    position = mPosition;
    //更新控制器位置
    node.position = position;
    shape.position = position;
    icon.position = position;
}
//设置控制器的半径
- (void) setRadius:(float)mRadius {
    if (mRadius < minRadius) {
        mRadius = minRadius;
    }
    if (mRadius > maxRadius) {
        mRadius = maxRadius;
    }
    if (radius == mRadius) {
        return;
    }
    radius = mRadius;
    //设置新的半径
    [node setScale:radius / initialRadius];
}

//根据控制器类型 调整发射物的方向，速度
- (void) updateAffectedProjectilesForDuration:(CFTimeInterval)duration {    //duration 控制器作用持续时间
    switch (controlType) {
        
         //方向控制器作用效果
        case CONTROL_TYPE_PUSH: {
            float xmag = powerVector.dx * duration;         //xmag 控制器对发射物，作用在x轴方向上速度
            float ymag = powerVector.dy * duration;         //xmag 控制器对发射物，作用在y轴方向上速度
            NSMutableArray *toRemove = [NSMutableArray array];
            //int i = 0;
            //对每个在作用效果范围内的发射物，调整速度和方向
            for (SKNode *mNode in affectedProjectiles) {
                
//                if (!mNode.parent) {
//                    NSLog(@"%d", i);
//                    i ++;
//                    [toRemove addObject:node];
//                }
                //改变发射物速度方向
                mNode.physicsBody.velocity = CGVectorMake(mNode.physicsBody.velocity.dx + xmag,
                                                          mNode.physicsBody.velocity.dy + ymag);
                
                //旋转发射物方向 反正切函数
                mNode.zRotation = atan2(mNode.physicsBody.velocity.dy,
                                        mNode.physicsBody.velocity.dx);

            }
            
            if ([toRemove count]) {
                for (SKNode *mNode in toRemove) {
                    [affectedProjectiles removeObjectIdenticalTo:mNode];
                    [mNode removeFromParent];
                }
            }
            break;
        }
            
         //增强控制器作用效果
        case CONTROL_TYPE_PROPEL: {
            float multiplier = 1 + power * duration;                //速度增大倍数
            for (SKNode *mNode in affectedProjectiles) {
                //增强后的速度
                mNode.physicsBody.velocity = CGVectorMake(mNode.physicsBody.velocity.dx * multiplier,
                                                          mNode.physicsBody.velocity.dy * multiplier);
            }
            break;
        }
            
         //减弱控制器作业效果
        case CONTROL_TYPE_SLOW: {
            float mutiplier = 1 - power * duration;                 //速度减弱倍数
            NSMutableArray *toRemove = [NSMutableArray array];      //待移除的发射物数组
            for (SKNode *mNode in affectedProjectiles) {
                //减弱后的速度
                mNode.physicsBody.velocity = CGVectorMake(mNode.physicsBody.velocity.dx * mutiplier,
                                                          mNode.physicsBody.velocity.dy * mutiplier);
                //如果发射物 x方向或者y方向上的速度小于3，则将其添加进待移除数组
                if (fabs(mNode.physicsBody.velocity.dx) < 3
                        && fabs(mNode.physicsBody.velocity.dy) < 3) {
                    [toRemove addObject:mNode];
                }
            }
            if([toRemove count]) {                                  //移除发射物
                for (SKNode *mNode in toRemove) {
                    [affectedProjectiles removeObjectIdenticalTo:mNode];
                    [mNode removeFromParent];
                }
            }
            break;
        }
    
        //引力控制器
        case CONTROL_TYPE_GRAVITY: {
            
            float multiplier = power * duration;
            float drag = 1 - (0.5) * duration;
            NSMutableArray *toRemove = [NSMutableArray array];
            for (SKNode *mNode in affectedProjectiles) {
                
                if (!mNode.parent) {
                    [toRemove addObject:mNode];
                }
                
                float dx = node.position.x - mNode.position.x;
                float dy = node.position.y - mNode.position.y;
                
                float dist = sqrt(dx * dx + dy * dy);
                dist += radius / 2;
                
                float force = multiplier * 50000 / (dist * dist);
                
                mNode.physicsBody.velocity = CGVectorMake((mNode.physicsBody.velocity.dx + dx * force) * drag,
                                                          (mNode.physicsBody.velocity.dy + dy * force) * drag);
                
                mNode.zRotation = atan2(mNode.physicsBody.velocity.dy,
                                        mNode.physicsBody.velocity.dx);
                
                float Vx = fabs(mNode.physicsBody.velocity.dx);
                float Vy = fabs(mNode.physicsBody.velocity.dy);
                
                if (Vx < 3 && Vy < 3) {
                    [toRemove addObject:mNode];
                } else if(fabs(dx) < 6 && fabs(dy) < 6 && Vx < 40 && Vy < 40) {
                    [toRemove addObject:mNode];
                }
            }
            if ([toRemove count]) {
                for (SKNode *mNode in toRemove) {
                    [affectedProjectiles removeObjectIdenticalTo:mNode];
                    [mNode removeFromParent];
                }
            }
            break;
        }
        //
        case CONTROL_TYPE_REPEL: {
            float multiplier = power * duration;
            for (SKNode *mNode in affectedProjectiles) {
                float dx = mNode.position.x - node.position.x;
                float dy = mNode.position.y - node.position.y;
                float dist = sqrt(dx * dx + dy * dy);
                dist += radius / 4;
                
                float force = multiplier * 50000 / (dist * dist);
                
                mNode.physicsBody.velocity = CGVectorMake(mNode.physicsBody.velocity.dx + dx *force,
                                                          mNode.physicsBody.velocity.dy + dy *force);
                mNode.zRotation = atan2(mNode.physicsBody.velocity.dy,
                                       mNode.physicsBody.velocity.dx);
            }
            break;
        }
        //虫洞控制器
        case CONTROL_TYPE_WARP: {
            for (SKNode *mNode in affectedProjectiles) {
                if (mNode.userData[@"warped"]) {
                    [mNode.userData removeObjectForKey:@"warped"];
                    continue;
                }
                
                float dx = mNode.position.x - self.position.x;
                float dy = mNode.position.y - self.position.y;
                
                mNode.userData[@"warped"] = @YES;
                mNode.position = CGPointMake(self.connectedWarp.position.x + dx,
                                             self.connectedWarp.position.y + dy);
                
                [self.scene removeNodeFromAllControlsNotInRange:mNode];

            }
            [affectedProjectiles removeAllObjects];
            break;
        }
         
        default:
            break;
    }
}
@end
































