//
//  HomeScene.h
//  BlockJourney
//
//  Created by StarJade on 14-12-13.
//
//

#ifndef __BlockJourney__HomeScene__
#define __BlockJourney__HomeScene__

#include "heads.h"

class HomeScene: public cocos2d::Layer {
	
	cocos2d::TransitionFadeBL * transition;
	
	cocos2d::Sprite * title;
	cocos2d::Node * flowHUD;
	cocos2d::MenuItemImage * arrowBtn;
	
	cocos2d::MenuItemImage * startFirstly;
	cocos2d::MenuItemImage * start;
	
	cocos2d::Label * comprehendLabel;
	cocos2d::Label * maxLifeRoundsLabel;
	
	bool inTitleState;//判断状态
	
public:
	bool init();
	static cocos2d::Scene * scene();
	CREATE_FUNC(HomeScene);
	
public:
	void onEnter();
//	void onExit();
	
public:
	void onStart(cocos2d::Ref* pSender);
	void onSwitch(cocos2d::Ref* pSender);
	void onToInfo(cocos2d::Ref* pSender);
	
	
};
#endif /* defined(__BlockJourney__HomeScene__) */
