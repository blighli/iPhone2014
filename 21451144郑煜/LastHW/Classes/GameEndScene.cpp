//
//  GameEndScene.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-10.
//
//

#include "public.h"


Scene *GameEndScene::scene(){
	// 'scene' is an autorelease object
	auto scene = Scene::create();
	
	// 'layer' is an autorelease object
	auto layer = GameEndScene::create();
	
	// add layer as a child to scene
	scene->addChild(layer);
	
	// return the scene
	return scene;
	
}

bool GameEndScene::init(){
	if (!Layer::init()) {
		return false;
	}
	
	// 添加所有元素，设置为不可见，按键失效
	Size winSize = Director::getInstance()->getWinSize();
	
	// 背景
	auto background = BackGroundLayer::create();
	this->addChild(background);
	
	// 标题
	failTitle = Sprite::create("fail.png");
	failTitle->setPosition(winSize.width/2,winSize.height * GameEndSceneData::TITLE_H_PERCENT);
	this->addChild(failTitle);
	failTitle->setVisible(false);
	
	winTitle = Sprite::create("win.png");
	winTitle->setPosition(winSize.width/2,winSize.height * GameEndSceneData::TITLE_H_PERCENT);
	this->addChild(winTitle);
	winTitle->setVisible(false);
	
	
	// HUD
	flowHUD = Node::create();
	flowHUD->setPosition(Vec2(winSize.width/2,winSize.height * GameEndSceneData::HUD_H_PERCENT));
	flowHUD->setContentSize(GameEndSceneData::HUD_CONTENT_SIZE);
	flowHUD->setAnchorPoint(Vec2(0.5,0.5));
	this->addChild(flowHUD);
	flowHUD->setVisible(false);
	
	// HUD 上背景
	auto hudBackground = Sprite::create("gameEndHUD.png");
	hudBackground->setPosition(flowHUD->getContentSize().width/2,flowHUD->getContentSize().height/2);
	flowHUD->addChild(hudBackground);
	
	// HUD 上经历轮回
	lifeRoundsLabel = Label::createWithCharMap("numbers.png",  28,53, '0');
	lifeRoundsLabel->setAlignment(TextHAlignment::LEFT);
	lifeRoundsLabel->setScale(0.7);
	lifeRoundsLabel->setAnchorPoint(Vec2(0,0.5));
	lifeRoundsLabel->setPosition(GameEndSceneData::LIFE_ROUNDS_POS);
	flowHUD->addChild(lifeRoundsLabel);
	
	lifeRoundsLabel->setString(GameData::sharedGameData()->getLifeRounds());
	
	// HUD 上最长历世
	maxLifeRoundsLabel = Label::createWithCharMap("numbers.png",  28,53, '0');
	maxLifeRoundsLabel->setAlignment(TextHAlignment::LEFT);
	maxLifeRoundsLabel->setScale(0.7);
	maxLifeRoundsLabel->setAnchorPoint(Vec2(0,0.5));
	maxLifeRoundsLabel->setPosition(GameEndSceneData::MAX_LIFE_ROUNDS_POS);
	flowHUD->addChild(maxLifeRoundsLabel);
	
	maxLifeRoundsLabel->setString(GameData::sharedGameData()->getMaxLifeRounds());
	
	// HUD2
	flowHUD2 = Node::create();
	flowHUD2->setPosition(Vec2(winSize.width/2,winSize.height * GameEndSceneData::HUD_H_PERCENT));
	flowHUD2->setContentSize(GameEndSceneData::HUD_CONTENT_SIZE);
	flowHUD2->setAnchorPoint(Vec2(0.5,0.5));
	this->addChild(flowHUD2);
	flowHUD2->setVisible(false);

	// HUD 上背景
	auto hudBackground2 = Sprite::create("HUDback.png");
	hudBackground2->setPosition(flowHUD2->getContentSize().width/2,flowHUD2->getContentSize().height/2);
	flowHUD2->addChild(hudBackground2);
	
	// 领悟等级
	comprehendLabel = Label::createWithBMFont("myfont.fnt", GameData::sharedGameData()->getComprehend(), TextHAlignment::CENTER);
	comprehendLabel->setPosition(flowHUD->getContentSize().width/2,flowHUD->getContentSize().height/2);
	flowHUD2->addChild(comprehendLabel);
	
	
	// 格言段
	
	motto = Sprite::create("illustrateFrame.png");
	motto->setPosition(Vec2(winSize.width/2,winSize.height * GameEndSceneData::MOTTO_H_PERCENT));
	this->addChild(motto);
	motto->setVisible(false);
	
	mottoLabel = Label::createWithSystemFont("000", "arial", 40);
	mottoLabel->setColor(Color3B(62,86,132));
	mottoLabel->setPosition(Vec2(winSize.width/2,winSize.height * GameEndSceneData::MOTTO_H_PERCENT));
	this->addChild(mottoLabel);
	mottoLabel->setVisible(false);
	
	
	
	// 再入尘世
	
	startGameMenuItem = MenuItemImage::create("startAgain.png", "startAgainSelected.png", CC_CALLBACK_1(GameEndScene::onToGame, this));
	startGameMenuItem->setPosition(Vec2(winSize.width/2,winSize.height * GameEndSceneData::MOTTO_H_PERCENT));
	startGameMenuItem->setVisible(false);
	startGameMenuItem->setEnabled(false);
	// Home
	
	auto homeMenuItem = MenuItemImage::create("home.png","homeSelected.png",CC_CALLBACK_1(GameEndScene::onToHome, this));
	homeMenuItem->setPosition(Vec2(72,winSize.height * GameEndSceneData::Btn_H_PERCENT));
	
	auto menu = Menu::create(startGameMenuItem,homeMenuItem,NULL);
	menu->setAnchorPoint(Vec2(0,0));
	menu->setPosition(Vec2::ZERO);
	this->addChild(menu);

	// 判断是否等级上升
	if (GameData::sharedGameData()->updateMaxComprehend()){
	
		// 注册监听
		this->registerTouchEvent();
		//显示标题
		winTitle->setVisible(true);
		// 显示hud
		flowHUD2->setVisible(true);
		// 显示motto
		motto->setVisible(true);
		mottoLabel->setString(GameData::sharedGameData()->getMotto());
		mottoLabel->setVisible(true);
	}else{
		//显示标题
		failTitle->setVisible(true);
		// 显示hud
		flowHUD->setVisible(true);
		// 显示开始按键
		startGameMenuItem->setVisible(true);
		startGameMenuItem->setEnabled(true);
		//
		
	}

	// 判断最长历世
	GameData::sharedGameData()->updateMaxLifeRounds();
	// 历史提升的显示
	
	return true;
}

void GameEndScene::onEnter(){
	Layer::onEnter();
	
}

void GameEndScene::onExit(){
	Layer::onExit();
}

void GameEndScene::onToHome(cocos2d::Ref* pSender){
	
	Director::getInstance()->replaceScene(HomeScene::scene());
	
}
void GameEndScene::onToGame(cocos2d::Ref* pSender){
	auto transition = TransitionFadeBL::create(0.6f, GameScene::scene());
	Director::getInstance()->replaceScene(transition);
}

bool GameEndScene::toNormal(cocos2d::Touch *touch, cocos2d::Event *unused_event){
	printf("\n\n\nGameEndScene::toNormal\n\n\n");
	// 显示hud
	flowHUD2->setVisible(false);
	// 显示motto
	motto->setVisible(false);
	mottoLabel->setVisible(false);

	// 显示hud
	flowHUD->setVisible(true);
	// 显示开始按键
	startGameMenuItem->setVisible(true);
	startGameMenuItem->setEnabled(true);
	//

	return true;
}

void GameEndScene::registerTouchEvent(){
	
	/// 获取事件分发器
	auto dispatcher = this->getEventDispatcher();
	
	/// 创建单点触摸监听器 EventListenerTouchOneByOne
	auto touchListener = EventListenerTouchOneByOne::create();
	
	/// 单点触摸响应事件绑定
	touchListener->onTouchBegan   = CC_CALLBACK_2(GameEndScene::toNormal, this);
	
	/// 在事件分发器中，添加触摸监听器，事件响应委托给 this 处理
	dispatcher->addEventListenerWithSceneGraphPriority(touchListener, this);
	

}