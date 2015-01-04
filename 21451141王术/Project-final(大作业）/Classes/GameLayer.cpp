#include "GameLayer.h"
#include "FloatWord.h"
#include "GameData.h"
#include "GameScene.h"
#include "StarMatrix.h"
#include "MenuScene.h"
#include "Audio.h"
#include "MenuLayer.h"
bool GameLayer::init(){
	if(!Layer::init()){
		return false;
	}
    Size visibleSize = Director::getInstance()->getVisibleSize();
    
    
    

	matrix = nullptr;
	this->scheduleUpdate();
	EventListenerTouchOneByOne* listener = EventListenerTouchOneByOne::create();
	listener->onTouchBegan = CC_CALLBACK_2(GameLayer::onTouchBegan,this);
    Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(listener, this);
    
	
	Sprite* background = Sprite::create("bg_mainscene.jpg");
	background->setPosition(visibleSize.width/2,visibleSize.height/2);
	this->addChild(background,-1);
	menu = TopMenu::create();
	this->addChild(menu);
	linkNum = Label::create("","Arial",40);
	linkNum->setPosition(visibleSize.width/2,visibleSize.height-250);
	linkNum->setVisible(false);
	this->addChild(linkNum,1);

	this->floatLevelWord();
//    auto labelws=Label::createWithSystemFont("by王术", "Courier", 30);
//    labelws->setPosition(Vec2(60,800-40));
//    addChild(labelws);
//    labelws->runAction(RepeatForever::create(RotateBy::create(6, Vec3(0, 180, 0))));
    //加入暂停
    MenuItemImage* btn = MenuItemImage::create("Item_pause.png","Item_pause.png",CC_CALLBACK_0(GameLayer::MyResume, this));
    Menu* menu2 = Menu::create(btn,NULL);
    menu2->alignItemsVertically();
    menu2->setPosition(visibleSize.width-btn->getContentSize().width,visibleSize.height-btn->getContentSize().height);
    this->addChild(menu2,10);
    
	return true;
}

void GameLayer::floatLevelWord(){
	Size visibleSize = Director::getInstance()->getVisibleSize();
	_levelMsg = FloatWord::create(
		"关卡" + cocos2d::String::createWithFormat(": %d",GAMEDATA::getInstance()->getNextLevel())->_string,
		50, Point(visibleSize.width,visibleSize.height/3*2)
		);
	this->addChild(_levelMsg,1);
	_levelMsg->floatIn(0.5f,CC_CALLBACK_0(GameLayer::floatTargetScoreWord,this));
	Audio::getInstance()->playReadyGo();
}

void GameLayer::floatTargetScoreWord(){
	Size visibleSize = Director::getInstance()->getVisibleSize();
	_targetScore = FloatWord::create(
		"目标" + cocos2d::String::createWithFormat(": %d",GAMEDATA::getInstance()->getNextScore())->_string + "分",
		50, Point(visibleSize.width,visibleSize.height/3)
		);
	this->addChild(_targetScore,1);
	_targetScore->floatIn(0.5f,CC_CALLBACK_0(GameLayer::removeFloatWord,this));
}

void GameLayer::removeFloatWord(){
	_levelMsg->floatOut(0.5f,nullptr);
	_targetScore->floatOut(0.5f,CC_CALLBACK_0(GameLayer::showStarMatrix,this));
}

void GameLayer::showStarMatrix(){
	matrix = StarMatrix::create(this);
	this->addChild(matrix);
}

void GameLayer::update(float delta){
	if(matrix){
		matrix->updateStar(delta);
	}
}

bool GameLayer::onTouchBegan(Touch* touch,Event* event){
	Point p = touch->getLocationInView();
	p = Director::getInstance()->convertToGL(p);
	CCLOG("x=%f y=%f",p.x,p.y);
	if(matrix){
		matrix->onTouch(p);
	}
	return true;
}

void GameLayer::refreshMenu(){
	menu->refresh();
}

void GameLayer::showLinkNum(int size){
	
	string s = String::createWithFormat("%d",size)->_string + "连击" +
		String::createWithFormat("%d",size*size*5)->_string + "分";
	linkNum->setString(s);
	linkNum->setVisible(true);
}

void GameLayer::hideLinkNum(){
	linkNum->setVisible(false);
}

void GameLayer::floatLeftStarMsg(int leftNum){
	Size visibleSize = Director::getInstance()->getVisibleSize();
	FloatWord* leftStarMsg1 = FloatWord::create("剩余" + String::createWithFormat("%d",leftNum)->_string +"个",
		50,Point(visibleSize.width,visibleSize.height/2));
	this->addChild(leftStarMsg1);
    int jiangLiScore = GAMEDATA::getInstance()->getJiangli(leftNum);
	FloatWord* leftStarMsg2 = FloatWord::create("奖励" + String::createWithFormat("%d",jiangLiScore)->_string + "分",
		50,Point(visibleSize.width,visibleSize.height/2 - 50));
	this->addChild(leftStarMsg2);

	leftStarMsg1->floatInOut(0.5f,1.0f,
				[=](){
					hideLinkNum();
					matrix->setNeedClear(true);
					GAMEDATA* data = GAMEDATA::getInstance();
					data->setCurScore(data->getCurScore() + jiangLiScore);
					if(data->getCurScore() > data->getHistoryScore()){
						data->setHistoryScore(data->getCurScore());
					}
					refreshMenu();
				});
	leftStarMsg2->floatInOut(0.5f,1.0f,nullptr);
}

void GameLayer::gotoNextLevel(){
	refreshMenu();
	floatLevelWord();
}

void GameLayer::gotoGameOver(){
	
	GAMEDATA::getInstance()->saveHighestScore();
	
	Size visibleSize = Director::getInstance()->getVisibleSize();
	FloatWord* gameOver = FloatWord::create(
		"GAME OVER",40,Point(visibleSize.width,visibleSize.height/2));
	this->addChild(gameOver);
	gameOver->floatIn(1.0f,[]{Director::getInstance()->replaceScene(MenuScene::create());});
}

void GameLayer::MyResume(){
    CCLOG("START!");
    Director::getInstance()->pushScene(MenuScene::create());
    
}
