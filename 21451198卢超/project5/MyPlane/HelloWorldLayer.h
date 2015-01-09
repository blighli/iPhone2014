//
//  HelloWorldLayer.h
//  MyPlane
//
//  Created by jiaoshoujie on 14-12-12.
//  Copyright jiaoshoujie 2014年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCFoePlane.h"
#import "CCProps.h"

#define WINDOWHEIGHT [[UIScreen mainScreen] bounds].size.height

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    // 背景
    CCSprite *BG1;
    CCSprite *BG2;
    
    // 分数
    CCLabelTTF *scoreLabel;
    int score;
    
    int adjustmentBG;
    
    // 玩家飞机
    CCSprite *player;
    // 子弹
    CCSprite *bullet;
    // 子弹数量
    int bulletSum;
    // 子弹样式
    BOOL isBigBullet;
    BOOL isChangeBullet;
    // 子弹速度
    int bulletSpeed;
    // 特殊子弹时间
    int bulletTiming;
    
    // 敌方飞机
    CCArray *foePlanes;
    
    // 添加飞机时机
    int bigPlan;
    int smallPlan;
    int mediumPlan;
    
    // 道具
    CCProps *prop;
    // 添加道具时机
    int props;
    // 是否存在
    BOOL isVisible;
    
    CCLabelTTF *gameOverLabel;
    CCMenu *restart;
    BOOL isGameOver;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
