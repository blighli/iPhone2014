//
//  MenuLayer.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//

#include "public.h"

bool MenuLayer::init(){
	if (!Layer::init()) {
		return false;
	}
	
	Size winSize = Director::getInstance()->getWinSize();
	this->setContentSize(Size(640,960));
	//添加按键
	
	auto homeBtn = MenuItemImage::create(
										  "home.png", "homeSelected.png",
										  CC_CALLBACK_1(MenuLayer::onBackToHome, this));
	
	homeBtn->setPosition(GameSceneData::HOME_BTN_POS.x,winSize.height * GameSceneData::HOME_H_PERCENT);
	
	menu = Menu::create(homeBtn, NULL);
	menu->setPosition(Vec2::ZERO);
	this->addChild(menu);
	
	menu->setEnabled(false);
	
	return true;
}

void MenuLayer::onBackToHome(cocos2d::Ref *pSender){
	//界面跳转
	
	auto scene = HomeScene::scene();
	Director::getInstance()->replaceScene(scene);
}

void MenuLayer::setEnable(bool enable){
	menu->setEnabled(enable);
}