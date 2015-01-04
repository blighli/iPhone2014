#include "TopMenu.h"
#include "GameData.h"
bool TopMenu::init(){
	if(!Node::init()){
		return false;
	}
	Size visibleSize = Director::getInstance()->getVisibleSize();
    
    //加入暂停按钮
    
   
    
	highestScore = Label::create(
		"最高分" + cocos2d::String::createWithFormat("%d",GAMEDATA::getInstance()->getHistoryScore())->_string,
		"Verdana-Bold",30
	);
	highestScore->setPosition(visibleSize.width/2,visibleSize.height - 50);
	this->addChild(highestScore);

	level = Label::create(
		"关卡" + cocos2d::String::createWithFormat("%d",GAMEDATA::getInstance()->getNextLevel())->_string,
		"Verdana-Bold",30
	);
	level->setPosition(100,visibleSize.height - 100);
	this->addChild(level);

	targetScore = Label::create(
		"目标" + cocos2d::String::createWithFormat("%d",GAMEDATA::getInstance()->getNextScore())->_string + "分",
		"Verdana-Bold",30
	);
	targetScore->setPosition(visibleSize.width-targetScore->getContentSize().width/2,visibleSize.height - 100);
	this->addChild(targetScore);

	curScore = Label::create(
	    cocos2d::String::createWithFormat("%d",GAMEDATA::getInstance()->getCurScore())->_string,
		"Verdana-Bold",50	
	);
	curScore->setPosition(visibleSize.width/2,visibleSize.height - 150);
	this->addChild(curScore);

	return true;
}

void TopMenu::refresh(){
	char buf[64];
	sprintf(buf,"%d",GAMEDATA::getInstance()->getCurScore());
	curScore->setString(buf);

    std::string history = "最高分" + cocos2d::String::createWithFormat("%d",GAMEDATA::getInstance()->getHistoryScore())->_string;
	highestScore->setString(history);

    std::string guanqia = "关卡" + cocos2d::String::createWithFormat("%d",GAMEDATA::getInstance()->getNextLevel())->_string;
	level->setString(guanqia);

    std::string target = "目标" + cocos2d::String::createWithFormat("%d",GAMEDATA::getInstance()->getNextScore())->_string + "分";
	targetScore->setString(target);
}

