//
//  AboutScene.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-19.
//
//

#include "public.h"


Scene *AboutScene::scene(){
	// 'scene' is an autorelease object
	auto scene = Scene::create();
	
	// 'layer' is an autorelease object
	auto layer = AboutScene::create();
	
	// add layer as a child to scene
	scene->addChild(layer);
	
	// return the scene
	return scene;
	
}

bool AboutScene::init(){
	if (!Layer::init()) {
		return false;
	}
	
	auto winSize = Director::getInstance()->getWinSize();
	
	// 添加背景
	auto background = BackGroundLayer::create();
	this->addChild(background);
	
	// 添加 信息
	auto about = Sprite::create("about.png");
	about->setPosition(winSize.width/2,winSize.height/2);
	about->setScale(0.8f);
	this->addChild(about);
	
	// 添加按键
	// Home
	
	auto homeMenuItem = MenuItemImage::create("home.png","homeSelected.png",CC_CALLBACK_1(AboutScene::onToHome, this));
	homeMenuItem->setPosition(Vec2(72,winSize.height * GameEndSceneData::Btn_H_PERCENT));
	
	auto menu = Menu::create(homeMenuItem,NULL);
	menu->setAnchorPoint(Vec2(0,0));
	menu->setPosition(Vec2::ZERO);
	this->addChild(menu);

	
	return true;
}

void AboutScene::onToHome(cocos2d::Ref *pSender){
	
	Director::getInstance()->replaceScene(HomeScene::scene());
}