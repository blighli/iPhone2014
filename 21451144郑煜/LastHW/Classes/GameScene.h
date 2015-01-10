//
//  GameScene.h
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//

/************************************
 *功能:游戏界面，管理游戏界面的所有事务
 *
 *1、对游戏界面的各个层进行管理
 *
 *	//	背景层
 *	//	游戏层
 *	//	HUD层
 *	//	Menu层
 *	//	准备层
 ************************************/
#ifndef __BlockJourney__GameScene__
#define __BlockJourney__GameScene__

#include "heads.h"

class GameScene:public cocos2d::Layer {
	
private:
	BackGroundLayer *backgroundLayer;
	GameWorldController *gameWorldLayer;
	HUDLayer *hudLayer;
	MenuLayer *menuLayer;
	PrepareLayer *prepareLayer;
	
	
	enum EnTag{
		BackgroundLayer = 10,
		GameWorldLayer,
		HUDLayer,
		MenuLayer,
		PrepareLayer,
	};
	
	enum EnZOrder{
		Z_BackgroundLayer = 10,
		Z_GameWorldLayer,
		Z_HUDLayer,
		Z_MenuLayer,
		Z_PrepareLayer,
	};
	
public:
	bool init();
	static cocos2d::Scene *scene();
	CREATE_FUNC(GameScene);
	
public:
	void onEnter();
	void onExit();
	
public:
	void onGameStart();
	void onGameEnd();
};

#endif /* defined(__BlockJourney__GameScene__) */
