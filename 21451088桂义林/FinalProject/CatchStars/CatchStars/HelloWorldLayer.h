//
//  HelloWorldLayer.h
//  CatchStars
//
//  Created by YilinGui on 14-12-19.
//  Copyright Yilin Gui 2014年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer<CCTouchAllAtOnceDelegate>
{
    // 游戏标题
    CCLabelTTF *gameTitleLabel;
    // 主菜单
    CCMenu *mainMenu;
    // 游戏中的暂停菜单
    CCMenu *pauseMenu;

    // 游戏暂停时的弹出菜单
    CCLabelTTF *pausePopupLabel;
    CCMenu *pausePopupMenu;
    // 游戏结束时的弹出菜单
    CCLabelTTF *gameOverPopupLabel;
    CCMenu *gameOverMenu;
    
    // 游戏结束时显示本次分数
    CCLabelTTF *yourScoreLabel;
    
    // 滚动背景
    CCSprite *BG1;
    CCSprite *BG2;
    NSInteger adjustmentBG;
    
    // 得分
    CCLabelTTF *scoreLabelText;
    CCLabelTTF *scoreLabel;
    int scoreInt;  // 得分
    
    // 剩余时间
    CCLabelTTF *rmnTimeLabelText;
    CCLabelTTF *rmnTimeLabel;
    int rmnTime;
    
    // 高分榜相关Label
    CCLabelTTF *leaderBoradLabel;
    CCLabelTTF *leader1;
    CCLabelTTF *leader2;
    CCLabelTTF *leader3;
    
    CCMenu *leadBdBackMenu;
    CCMenu *helpBackMenu;
    
    // 判断游戏是否结束
    BOOL isGameOver;
    // 判断游戏暂停
    BOOL isGamePause;
    
    CCSprite *yellowStar;  // 要抓住的黄色星星
    CCSprite *bomb;  // 炸弹
    
    CCSprite *helpInfo;
    
    int yellowStarTime;
    int bombTime;
    int bombTimeCnt;
    float starSlowSpeed;  // 星星缓慢移动的速度
    float starFastSpeed;  // 星星逃跑的速度
    float impactDistance;  // 手指触摸的影响半径
    
    BOOL isShowTitleAndMenu;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

// 初始化数据
- (void)initData;

// 加载背景
- (void)loadBackground;

// 回到标题画面
- (void)backToTitleAndMenu;

@end
