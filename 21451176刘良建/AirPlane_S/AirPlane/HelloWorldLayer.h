//
//  HelloWorldLayer.h
//  AirPlane
//
//  Created by JANESTAR on 14-12-15.
//  Copyright JANESTAR 2014年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCProps.h"
#import "CCFoePlane.h"

#define WINDOWHEIGHT [[UIScreen mainScreen] bounds].size.height
#define WINDOWWIDTH [[UIScreen mainScreen] bounds].size.width
// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    // 背景
    CCSprite *BG1;
    CCSprite *BG2;
    CCSprite * about;
   
    // 分数
    CCLabelTTF *scoreLabel;
    int score;
    
    int adjustmentBG;
    
    // 玩家飞机
    CCSprite *player;
    //飞机生命值
    int hd;
    // 我方子弹
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
    CCLabelTTF* intro;
    CCLabelTTF* intro2;
    CCLabelTTF *gameOverLabel;
    CCLabelTTF *gameTitle;
    CCMenu *restart;
    CCMenu* begin;
    CCMenu *starMenu;
    CCMenu* back;
    BOOL isGameOver;
    
    
    
    
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
