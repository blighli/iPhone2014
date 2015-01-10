//
//  LifeCircle.h 生命框
//  BlockJourney
//
//  Created by StarJade on 14-12-6.
//
//
/************************************
 *功能：提供能够旋转的生命框
 *
 *注意：在游戏中的位置不由自己控制
 ************************************/
#ifndef __BlockJourney__LifeCircle__
#define __BlockJourney__LifeCircle__

#include "heads.h"

class LifeCircle: public RectDrawNode {
	
private:
	cocos2d::Sprite * splashes[LENGTH*LENGTH];
	
	RotateEffectsNode * rotateEffectsNode;
	
	bool touchEnable;//触摸使能
	
public:
	bool init();
	CREATE_FUNC(LifeCircle);
	
public:
	void resetLifeCircle();
	
	void rotate();
	void antiRotate();
	
	void fillLifeCircle();// 填满生命框
	void runCollisionEffects(cocos2d::CallFunc *callback);//展示碰撞效果
	
	
	
private:
	void redraw();
	
	void initRotateSprites();
	void runRotateEffects(bool isCW);//执行旋转动画
	void rotateEffectsEnd();// 旋转动画结束
	
	
};
#endif /* defined(__BlockJourney__LifeCircle__) */
