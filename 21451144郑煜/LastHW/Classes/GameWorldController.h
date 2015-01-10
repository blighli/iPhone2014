//
//  GameWorldController.h
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//
/************************************
 *功能：控制游戏世界的正常运作
 *
 *1、控制轮回框的运动
 *2、控制生命框的旋转（提供交互）
 ************************************/
#ifndef __BlockJourney__GameWorldController__
#define __BlockJourney__GameWorldController__

#include "heads.h"

//typedef std::function<void (void)> Fun00;

class GameWorldController: public cocos2d::Layer {
	
private:
//	const cocos2d::Vec2 INIT_POS = GameSceneData::ROUND_CIRCLE_POS; // 轮回框出生位置
//	const cocos2d::Vec2 DEST_POS = GameSceneData::LIFE_CIRCLE_POS;	// 生命框所在位置
	
	
	cocos2d::EventListenerTouchOneByOne *touchListener;
	LifeCircle *lifeCircle;
	RoundCircle *roundCircle;
	
	cocos2d::Sprite *halo;//光晕
	
	Fun00 gameEndCB;
	
	bool isCollision;
	
	
public:
	bool init(Fun00 gameEndCB);
	static GameWorldController *create(Fun00 gameEndCB);
	
public:
	void startRun();
	bool onTouchBegan(cocos2d::Touch *touch, cocos2d::Event *unused_event){return true;};
	void onTouch(cocos2d::Touch *touch, cocos2d::Event *unused_event);
	
private:
	void registerTouchEvent();// 注册touch事件
	
	void onCrash();
	void handleCrash();
	
	
};

#endif /* defined(__BlockJourney__GameWorldController__) */
