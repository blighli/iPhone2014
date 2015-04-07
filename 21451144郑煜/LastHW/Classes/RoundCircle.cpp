//
//  RoundCircle.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-6.
//
//

#include "public.h"

bool RoundCircle::init(cocos2d::Vec2 initPos,cocos2d::Vec2 destPos,Fun00 cb){
	
	if (!RectDrawNode::init()) {
		return false;
	}
	
	this->initPos = initPos;
	this->destPos = destPos;
	this->cb = cb;
	
	resetRoundCircle();
	return true;
}

RoundCircle *RoundCircle::create(cocos2d::Vec2 initPos,cocos2d::Vec2 destPos,Fun00 cb){
	
	RoundCircle *pRet = new RoundCircle();
	
	if (pRet && pRet->init(initPos,destPos,cb)) {
		pRet->autorelease();
		return pRet;
	}else{
		delete pRet;
		pRet = NULL;
		return NULL;
	}
}


void RoundCircle::resetAndMoveRoundCircle(){
	resetRoundCircle();
	move();
}

void RoundCircle::resetRoundCircle(){

	auto shape = ShapeModel::sharedModel()->resetMoveShape();
	this->setPosition(initPos);
	this->setScale(INIT_SCALE);
	this->RedrawRect(shape);
	this->setColor(Color3B(255,0,0));
	
}

void RoundCircle::move(){
	
	printf("\n\n\n RoundCircle::move() \n\n");
	
	//	缩放
	auto zoomIn = ScaleTo::create(MOVE_TIME, 1.0f);
	//	移动
	auto vec = Vec2(destPos.x - initPos.x, destPos.y - initPos.y);
	auto moveBy = MoveBy::create(MOVE_TIME, vec);
	auto easeIn = EaseIn::create(moveBy, 2.5);//设置为匀加速运动
	
	//	缩放和移动同时发生
	auto spawn = Spawn::create(zoomIn, easeIn, NULL);
	
	// 添加回调
	auto callFunc = CallFunc::create(this->cb);
	//	添加顺序序列
	auto seqAct = Sequence::create(spawn,callFunc, NULL);
	
	//	执行
	this->runAction(seqAct);
}

