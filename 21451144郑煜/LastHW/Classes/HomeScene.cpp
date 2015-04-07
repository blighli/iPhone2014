//
//  HomeScene.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-13.
//
//

#include "public.h"

Scene *HomeScene::scene(){
	// 'scene' is an autorelease object
	auto scene = Scene::create();
	
	// 'layer' is an autorelease object
	auto layer = HomeScene::create();
	
	// add layer as a child to scene
	scene->addChild(layer);
	
	// return the scene
	return scene;
}

void HomeScene::onEnter(){
	Layer::onEnter();
	inTitleState = true;
}
bool HomeScene::init(){
	if (!Layer::init()) {
		return false;
	}
	
	
	
	Size winSize = Director::getInstance()->getWinSize();
	
	//添加背景
	auto background = BackGroundLayer::create();
	this->addChild(background);
	
	// 添加标题
	title = Sprite::create("gameTitle.png");
	title->setPosition(winSize.width/2,winSize.height * HomeSceneData::TITLE_H_PERCENT);
	this->addChild(title);
	title->setVisible(false);
	
	
	// HUD
	flowHUD = Node::create();
	flowHUD->setContentSize(HomeSceneData::HUD_CONTENT_SIZE);
	flowHUD->setPosition(winSize.width/2,winSize.height * HomeSceneData::TITLE_H_PERCENT);
	flowHUD->setAnchorPoint(Vec2(0.5,0.5));
	this->addChild(flowHUD);
	flowHUD->setVisible(false);
	
	// HUD 背景
	auto hudBackground = Sprite::create("startHUD.png");
	hudBackground->setPosition(flowHUD->getContentSize().width/2,flowHUD->getContentSize().height/2);
	flowHUD->addChild(hudBackground);

	
	// 领悟

	comprehendLabel = Label::createWithBMFont("myfont.fnt", GameData::sharedGameData()->getComprehend(), TextHAlignment::LEFT);
	comprehendLabel->setAnchorPoint(Vec2(0,0.5));
	comprehendLabel->setPosition(HomeSceneData::COMPREHEND_POS);
	flowHUD->addChild(comprehendLabel);
	
	// 最长历世
	maxLifeRoundsLabel = Label::createWithCharMap("numbers.png",  28,53, '0');
	maxLifeRoundsLabel->setAlignment(TextHAlignment::LEFT);
//	maxLifeRoundsLabel->setScale(0.4);
	maxLifeRoundsLabel->setAnchorPoint(Vec2(0,0.5));
	maxLifeRoundsLabel->setPosition(HomeSceneData::MAX_LIFE_ROUND_POS);
	flowHUD->addChild(maxLifeRoundsLabel);
	
	
	
	// 箭头按键
	arrowBtn = MenuItemImage::create("arrow.png", "arrowSelected.png", CC_CALLBACK_1(HomeScene::onSwitch, this));
	arrowBtn->setPosition(HomeSceneData::ARROW_BUTTON_POS);
	arrowBtn->setScale(1.3f);
//	arrowBtn->setContentSize(Size(80,80));
	arrowBtn->setVisible(false);
	arrowBtn->setEnabled(false);
	
	// HUD菜单
	auto hudMenu = Menu::create(arrowBtn,nullptr);
	hudMenu->setPosition(0,winSize.height * HomeSceneData::TITLE_H_PERCENT-flowHUD->getContentSize().height/2);
	this->addChild(hudMenu);
	
	
	
	// 开始
	start = MenuItemImage::create("startAgain.png", "startAgainSelected.png", CC_CALLBACK_1(HomeScene::onStart, this));
	start->setPosition(winSize.width/2,winSize.height * HomeSceneData::START_H_PERCENT);
	start->setVisible(false);
	start->setEnabled(false);
	
	
	// 第一次开始
	startFirstly = MenuItemImage::create("start.png", "startSelected.png", CC_CALLBACK_1(HomeScene::onStart, this));
	startFirstly->setPosition(winSize.width/2,winSize.height * HomeSceneData::START_H_PERCENT);
	startFirstly->setVisible(false);
	startFirstly->setEnabled(false);

	
	
	//关于按键
	
	auto infoBtn = MenuItemImage::create("info.png","infoSelected.png",CC_CALLBACK_1(HomeScene::onToInfo, this));
	infoBtn->setPosition(72,winSize.height *HomeSceneData::BUTTON_H_PERCENT);
	
	
	// 开始菜单
	auto menu = Menu::create(start,startFirstly,infoBtn,nullptr);
	menu->setPosition(Vec2::ZERO);
	this->addChild(menu);
	
	
	
	
	
	
	
	// 是否是第一次开始
	string str = GameData::sharedGameData()->getMaxLifeRounds();
	
	title->setVisible(true);
	
	if (str.compare("0") == 0){
		
		startFirstly->setVisible(true);
		startFirstly->setEnabled(true);

	}else{
		
		arrowBtn->setVisible(true);
		arrowBtn->setEnabled(true);
		
		start->setVisible(true);
		start->setEnabled(true);
		
		
		maxLifeRoundsLabel->setString(str);
	}
	
	
	
	return true;
	
}

void HomeScene::onSwitch(cocos2d::Ref *pSender){
	if (inTitleState) {
		flowHUD->setVisible(true);
		title->setVisible(false);
	}else{
		title->setVisible(true);
		flowHUD->setVisible(false);
	}
	inTitleState = !inTitleState;
}
void HomeScene::onStart(cocos2d::Ref *pSender){
	auto transition = TransitionFadeBL::create(0.6f, GameScene::scene());
	Director::getInstance()->replaceScene(transition);
}

void HomeScene::onToInfo(cocos2d::Ref *pSender){
	auto transition = TransitionFadeBL::create(0.6f, AboutScene::scene());
	Director::getInstance()->replaceScene(transition);
}
