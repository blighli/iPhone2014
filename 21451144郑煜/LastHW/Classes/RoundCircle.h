//
//  RoundCircle.h 轮回框
//  BlockJourney
//
//  Created by StarJade on 14-12-6.
//
//
/************************************
 *功能：提供移动操作以及移动结束的回调
 *
 *注意：该类能够自主管理在游戏中的位置
 ************************************/
#ifndef __BlockJourney__RoundCircle__
#define __BlockJourney__RoundCircle__

#include "heads.h"

class RoundCircle: public RectDrawNode {
private:
	const float MOVE_TIME = 2.7f;
	const float INIT_SCALE = 0.1f;
	
	cocos2d::Vec2 initPos;
	cocos2d::Vec2 destPos;
	Fun00 cb;
	
public:
	bool init(cocos2d::Vec2 initPos,cocos2d::Vec2 destPos,Fun00 cb);
	
	static RoundCircle *create(cocos2d::Vec2 initPos,cocos2d::Vec2 destPos,Fun00 cb);
	
public:
	void resetAndMoveRoundCircle();

private:
	void resetRoundCircle();
	void move();
	
};

#endif /* defined(__BlockJourney__RoundCircle__) */
