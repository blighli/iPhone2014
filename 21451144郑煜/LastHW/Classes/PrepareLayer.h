//
//  PrepareLayer.h
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//

/************************************
 *功能：准备层是游戏开始前的准备，可以覆盖一层说明。
 *
 *
 *
 ************************************/
#ifndef __BlockJourney__PrepareLayer__
#define __BlockJourney__PrepareLayer__

#include "heads.h"

class PrepareLayer: public cocos2d::LayerColor {
	
	Fun00 gameStartCB;
	
public:
	bool init(Fun00 gameStartCB);
	static PrepareLayer *create(Fun00 gameStartCB);
	
public:
	
	bool onTouch(cocos2d::Touch *touch, cocos2d::Event *unused_event);
	void registerTouchEvent();// 注册touch事件
	
	
};

#endif /* defined(__BlockJourney__PrepareLayer__) */
