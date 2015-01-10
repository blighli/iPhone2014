//
//  GameScene.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//

#include "public.h"


bool GameScene::init(){
	
	if (!Layer::init()) {
		return false;
	}
	
	Vec2 origin = Director::getInstance()->getVisibleOrigin();
	//	添加背景层
	backgroundLayer = BackGroundLayer::create();
	this->addChild(backgroundLayer,EnTag::BackgroundLayer,EnZOrder::Z_BackgroundLayer);
	
	
	//	添加游戏世界层
	gameWorldLayer = GameWorldController::create(CC_CALLBACK_0(GameScene::onGameEnd, this));
	this->addChild(gameWorldLayer,EnTag::GameWorldLayer,EnZOrder::Z_GameWorldLayer);
	
	

	
	//	添加HUD层
	hudLayer = HUDLayer::create();
	this->setPosition(origin);
	this->addChild(hudLayer,EnTag::HUDLayer,EnZOrder::Z_HUDLayer);
	
	//	添加Menu层
	menuLayer = MenuLayer::create();
	this->addChild(menuLayer,EnTag::MenuLayer,EnZOrder::Z_MenuLayer);
	
	//	添加准备层
	prepareLayer = PrepareLayer::create(CC_CALLBACK_0(GameScene::onGameStart, this));
	this->addChild(prepareLayer,EnTag::PrepareLayer,EnZOrder::Z_PrepareLayer);

	return true;
}

Scene *GameScene::scene(){
	// 'scene' is an autorelease object
	auto scene = Scene::create();
	
	// 'layer' is an autorelease object
	auto layer = GameScene::create();
	
	// add layer as a child to scene
	scene->addChild(layer);
	
	// return the scene
	return scene;

}

////////////////////////////////////
void GameScene::onEnter(){
	Layer::onEnter();
	GameData::sharedGameData()->reset();
}

void GameScene::onExit(){
	Layer::onExit();
	
}

////////////////////////////////////

void GameScene::onGameStart(){
	printf("\n\n\n\nGameScene::onGameStart\n\n\n");
	// 移除准备层
	this->removeChild(prepareLayer);
	gameWorldLayer->startRun();
	menuLayer->setEnable(true);
}


void GameScene::onGameEnd(){
	auto transition = TransitionFadeBL::create(1.0f, GameEndScene::scene());// 或者TransitionTurnOffTiles
	Director::getInstance()->replaceScene(transition);
	
}
