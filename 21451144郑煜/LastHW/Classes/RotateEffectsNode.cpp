//
//  RotateEffectsNode.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-19.
//
//

#include "public.h"

bool RotateEffectsNode::init(Fun00 cb){
	
	if (!Node::init()) {
		return false;
	}
	
	this->cb = cb;
	
	// 添加精灵
	for (int i = 0; i < 4; ++i) {
		comet[i]=Sprite::create("comet.png");
		comet[i]->setOpacity(0);
		comet[i]->setScale(0.8f);
		this->addChild(comet[i]);
	}
	
	
	// 设置初始变量
	this->setContentSize(Size(Vec2(640,393)));
	this->setAnchorPoint(Vec2(0.5,0.5));
	
	initPos[0] = Vec2(91,88);
	initPos[1] = Vec2(131,354);
	initPos[2] = Vec2(575,292);
	initPos[3] = Vec2(461,37);
	
	destPos[0] = Vec2(64,271);
	destPos[1] = Vec2(522,354);
	destPos[2] = Vec2(533,100);
	destPos[3] = Vec2(167,37);
	
	// 距离向量 和角度
	for (int i = 0; i < 4; ++i) {
	
		// 距离
		vec[i] = destPos[i] - initPos[i];
		antiVec[i] = vec[i];
		antiVec[i].negate();
		
		// 角度
		float rad = vec[i].getAngle(Vec2(-1,0));
		float ang = rad * 180 / 3.14;
		comet[i]->setRotation(ang);
		comet[i]->setPosition(initPos[i]);
	}
	
	//
	
	
	return true;
}

RotateEffectsNode *RotateEffectsNode::create(Fun00 cb){
	
	RotateEffectsNode *pRet = new RotateEffectsNode();
	
	if (pRet && pRet->init(cb)) {
		pRet->autorelease();
		return pRet;
	}else{
		delete pRet;
		pRet = NULL;
		return NULL;
	}
}

void RotateEffectsNode::runRotateEffects(bool isCW){

	for (int i = 0; i < 4; ++i) {
		Vec2 startPos;
		Vec2 vector;
		
		
		float rad = vec[i].getAngle(Vec2(-1,0));
		float ang = rad * 180 / 3.14;
		
		if (isCW) {
			startPos = initPos[i];
			vector = vec[i];
			comet[i]->setRotation(ang);

		}else{
			startPos = destPos[i];
			vector = antiVec[i];
			comet[i]->setRotation(ang+180);

			
		}
		
		// 设置为可见
		comet[i]->setPosition(startPos);
		comet[i]->setOpacity(255);
		
		// 移动、渐隐
		auto move = MoveBy::create(0.1f, vector);
		auto fadeOut = FadeOut::create(0.1f);
		
		auto effectEndCB = CallFunc::create(cb);
		
		auto spawn = Spawn::create(move, NULL);
		auto seq = Sequence::create(spawn,fadeOut, effectEndCB,NULL);
		
		comet[i]->runAction(seq);
		
		
	}
}

////////////////////////////////////
void RotateEffectsNode::setRotation(int i){
	
	float rad = vec[i].getAngle(Vec2(-1,1));
	float ang = rad * 180 / 3.14;
	comet[i]->setRotation(ang);
}
