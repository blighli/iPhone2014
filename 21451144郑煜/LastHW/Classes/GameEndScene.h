//
//  GameEndScene.h
//  BlockJourney
//
//  Created by StarJade on 14-12-10.
//
//

#ifndef __BlockJourney__GameEndScene__
#define __BlockJourney__GameEndScene__

#include "heads.h"

class GameEndScene: public cocos2d::Layer {
	
	cocos2d::Label *lifeRoundsLabel;
	cocos2d::Label * maxLifeRoundsLabel;
	cocos2d::Label * comprehendLabel;
	
	cocos2d::Sprite *winTitle;
	cocos2d::Node *flowHUD2;
	cocos2d::Sprite *motto;
	cocos2d::Label *mottoLabel;
	
	cocos2d::Sprite *failTitle;
	cocos2d::Node *flowHUD;
	cocos2d::MenuItem *startGameMenuItem;
	
	
	
public:
	bool init();
	static cocos2d::Scene *scene();
	CREATE_FUNC(GameEndScene);
	
public:
	void onEnter();
	void onExit();
	
public:
	bool toNormal(cocos2d::Touch *touch, cocos2d::Event *unused_event); // 转到正常游戏结束界面
	void onToHome(cocos2d::Ref* pSender);
	void onToGame(cocos2d::Ref* pSender);//进入游戏
	
	void registerTouchEvent();
	
	
};

#endif /* defined(__BlockJourney__GameEndScene__) */
