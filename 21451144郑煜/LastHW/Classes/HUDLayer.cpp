//
//  HUDLayer.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//

#include "public.h"

bool HUDLayer::init(){
	if (!Layer::init()) {
		return false;
	}
	
	Size winSize = Director::getInstance()->getWinSize();
	// 添加容器
	auto flowHUD = Node::create();
	flowHUD->setAnchorPoint(Vec2(0,1));
	flowHUD->setPosition(Vec2(0,winSize.height));
	flowHUD->setContentSize(GameSceneData::HUD_Content_Size);
	this->addChild(flowHUD);

	
	// 文字部分
	auto hudtext = Sprite::create("text.png");
	hudtext->setPosition(GameSceneData::HUD_TEXT_POS);
	flowHUD->addChild(hudtext);
	
	// 残念
	remnantsLabel = Label::createWithCharMap("numbers.png",  28,53, '0');
	remnantsLabel->setAlignment(TextHAlignment::RIGHT);
	remnantsLabel->setScale(0.4);
	remnantsLabel->setAnchorPoint(Vec2(1,0.5));
	remnantsLabel->setPosition(GameSceneData::HUD_REMNANTS_POS);
	flowHUD->addChild(remnantsLabel);

	remnantsLabel->setString(GameData::sharedGameData()->getRemnants());

	//领悟等级
	comprehendLabel = Label::createWithBMFont("myfont1.fnt", GameData::sharedGameData()->getComprehend(), TextHAlignment::LEFT);
	comprehendLabel->setAnchorPoint(Vec2(0,1));
	comprehendLabel->setPosition(GameSceneData::HUD_COMPREHEND_POS);
	flowHUD->addChild(comprehendLabel);
	
	// 指针
	pointer = Sprite::create("pointer.png");
	pointer->setPosition(GameSceneData::HUD_POINT_START_POS);
	flowHUD->addChild(pointer);
	
	// 进度条
	process = Sprite::create("process.png");
	process->setPosition(GameSceneData::HUD_PROCESS_POS);
	process->setAnchorPoint(Vec2(0,0.5));
	flowHUD->addChild(process);
	
	// 圆盘
	auto target = Sprite::create("target.png");
	target->setPosition(GameSceneData::HUD_TARGET_POS);
	flowHUD->addChild(target);
	
	// 添加帧刷新
	this->scheduleUpdate();
	
	return true;
}

void HUDLayer::update(float dt){
	
	//更新显示数据
	remnantsLabel->setString(GameData::sharedGameData()->getRemnants());
	auto gameData = GameData::sharedGameData();
	comprehendLabel->setString(GameData::sharedGameData()->getComprehend());
	
	//更新进度条 （x-src）/（dest-src） = remnant / need
	
	// 指针
	float x = gameData->getComprehendProgress() * (GameSceneData::HUD_POINT_END_POS.x - GameSceneData::HUD_POINT_START_POS.x) + GameSceneData::HUD_POINT_START_POS.x;
	pointer->setPosition(x,pointer->getPosition().y);
	
	// 长条
	process->setScaleX(gameData->getComprehendProgress());
	
	
	

}



