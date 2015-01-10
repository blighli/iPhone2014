//
//  GameWorldController.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//

#include "public.h"

bool GameWorldController::init(Fun00 gameEndCB){
	
	if (!Layer::init()) {
		return false;
	}
	
	this->gameEndCB = gameEndCB;
	isCollision = false;
	
	Size winSize = Director::getInstance()->getWinSize();
	
	// 初始化轮回圈
	Vec2 srcPos = Vec2(GameSceneData::ROUND_CIRCLE_POS.x,winSize.height * GameSceneData::ROUND_CIRCLE_H_PERCENT);
	Vec2 destPos = Vec2(GameSceneData::LIFE_CIRCLE_POS.x,winSize.height * GameSceneData::LIFE_CIRCLE_H_PERCENT);
	roundCircle = RoundCircle::create(srcPos, destPos, CC_CALLBACK_0(GameWorldController::onCrash, this));
	this->addChild(roundCircle);
	
	// 初始化生命圈
	lifeCircle = LifeCircle::create();
	lifeCircle->setPosition(destPos);
	this->addChild(lifeCircle);
	
	// 特效
	halo = Sprite::create("halo.png");
	halo->setScale(0.1f);
	halo->setOpacity(0);
	halo->setPosition(destPos);
	this->addChild(halo);

	
	
	
	

	return true;
}

GameWorldController * GameWorldController::create(Fun00 gameEndCB){
	
	GameWorldController *pRet = new GameWorldController();
	
	if (pRet && pRet->init(gameEndCB)) {
		pRet->autorelease();
		return pRet;
	}else{
		delete pRet;
		pRet = NULL;
		return NULL;
	}

}

void GameWorldController::registerTouchEvent(){
	
	/// 获取事件分发器
	auto dispatcher = this->getEventDispatcher();
 
	
	/// 创建单点触摸监听器 EventListenerTouchOneByOne
	touchListener = EventListenerTouchOneByOne::create();
	
	/// 单点触摸响应事件绑定
	touchListener->onTouchBegan   = CC_CALLBACK_2(GameWorldController::onTouchBegan, this);
	touchListener->onTouchEnded   = CC_CALLBACK_2(GameWorldController::onTouch, this);
	/// 在事件分发器中，添加触摸监听器，事件响应委托给 this 处理
	dispatcher->addEventListenerWithSceneGraphPriority(touchListener, this);
}

void GameWorldController::startRun(){
	
	
	// 注册触摸监听
	this->registerTouchEvent();
	
	// 生命框重置 //不应该重置（2014.12.7）
//	lifeCircle->resetLifeCircle();
	
	// 轮回框重置并移动
	roundCircle->resetAndMoveRoundCircle();
	
}

void GameWorldController::onCrash(){
	
	// 移除触摸监听
	_eventDispatcher->removeEventListener(touchListener);
	
	isCollision = ShapeModel::sharedModel()->isOverlap();
	
	
	
	// 事件回调
	auto handleCrashCB = CallFunc::create(CC_CALLBACK_0(GameWorldController::handleCrash, this));
	
	if (isCollision){
		
		lifeCircle->runCollisionEffects(handleCrashCB);

	}else{
		
		// 光晕特效动作
		auto zoomIn = ScaleTo::create(0.4f, 1);
		auto fadeOut = FadeOut::create(0.4f);
		
		// 执行光晕特效
		halo->setScale(0.1f);
		halo->setOpacity(255);
		
		auto spawn = Spawn::create(zoomIn, fadeOut,NULL);
		auto seq = Sequence::create(spawn, handleCrashCB, NULL);
		halo->runAction(seq);

	}
	
}

void GameWorldController::handleCrash(){

	this->registerTouchEvent();
	
	// 触摸重新使能
//	_eventDispatcher->addEventListenerWithSceneGraphPriority(touchListener, this);
//	
	if (isCollision) {
		
		// 游戏结束
		gameEndCB();
		
	}else{
		// 轮回框重置并移动
		lifeCircle->resetLifeCircle();
		roundCircle->resetAndMoveRoundCircle();
		
		// 轮回数增加
		GameData::sharedGameData()->addRound();
	}
}


void GameWorldController::onTouch(Touch *touch, Event *unused_event){
	
	//如果触摸区域
	Size winSize = Director::getInstance()->getWinSize();
	if (touch->getLocation().y > winSize.height * 0.2f) return;
	
	auto offset = 20; //偏移量
	
	auto vec = touch->getLocation() - touch->getStartLocation(); //移动向量
	
	if (vec.project(Vec2(1, 0)).x > offset) {

		lifeCircle->antiRotate();
		
	}else if ( vec.project(Vec2(1, 0)).x < -offset){
		
		lifeCircle->rotate();
	}
	
}

