//
//  PrepareLayer.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//

#include "public.h"

bool PrepareLayer::init(Fun00 gameStartCB){
	
	if (!LayerColor::init()) {
		return false;
	}
	
	this->gameStartCB = gameStartCB;
	
	//添加图片
	
	// 帮助文字
	auto helptext = Sprite::create("prepareMask.png");
	helptext->setAnchorPoint(Vec2(0,0));
	this->addChild(helptext);
	
	// 箭头
	auto leftArrow = Sprite::create("leftArrow.png");
	leftArrow->setPosition(GameSceneData::LEFT_ARROW_POS);
	this->addChild(leftArrow);
	
	auto rightArrow = Sprite::create("rightArrow.png");
	rightArrow->setPosition(GameSceneData::RIGHT_ARROW_POS);
	this->addChild(rightArrow);
	
	
	
	
	// 注册触摸事件
	this->registerTouchEvent();
	return true;
}
PrepareLayer *PrepareLayer::create(Fun00 gameStartCB){
	
	PrepareLayer *pRet = new PrepareLayer();
	
	if (pRet && pRet->init(gameStartCB)) {
		pRet->autorelease();
		return pRet;
	}else{
		delete pRet;
		pRet = NULL;
		return NULL;
	}
	
}

bool PrepareLayer::onTouch(cocos2d::Touch *touch, cocos2d::Event *unused_event){
	printf("\n\n\n\nPrepareLayer::onTouch\n\n\n");
	
	// 游戏开始
	gameStartCB();
	
	return true;
}
void PrepareLayer::registerTouchEvent(){
	
	/// 获取事件分发器
	auto dispatcher = this->getEventDispatcher();
 
	/// 创建单点触摸监听器 EventListenerTouchOneByOne
	auto touchListener = EventListenerTouchOneByOne::create();
	
	/// 单点触摸响应事件绑定
	touchListener->onTouchBegan   = CC_CALLBACK_2(PrepareLayer::onTouch, this);
	
	/// 在事件分发器中，添加触摸监听器，事件响应委托给 this 处理
	touchListener->setSwallowTouches(true);
	dispatcher->addEventListenerWithSceneGraphPriority(touchListener, this);
}


