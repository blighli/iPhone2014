#include "End.h"
#include "GameScene.h"

Scene *End::createScene(int grade)
{
	auto scene = Scene::create();
	auto lay = End::create(grade);
	scene->addChild(lay,0);
	return scene;
}
End*End::create(int grade)
{
	End *pRet = new End(); 
	pRet->grade = grade;
	if (pRet && pRet->init()) 
	{ 
	pRet->autorelease(); 
	return pRet; 
	} 
	else 
	{ 
	delete pRet; 
	pRet = NULL; 
	return NULL; 
	} 
}
bool End::init()
{
	Layer::init();
	visibleSize = Director::getInstance()->getVisibleSize();
	origin = Director::getInstance()->getVisibleOrigin();
	
	//add bac
	addBac();
	addLabel();
	addGrade();

	auto tryagain= MenuItemImage::create(startnormal, startselected, CC_CALLBACK_1(End::gameagain, this));
	tryagain->setScale(visibleSize.height / tryagain->getContentSize().height / 10);
	//auto label_start = LabelTTF::create("StartGame", "verdana", 20);
	auto label_start = Label::create("TryAgain", "verdana", 30, Size::ZERO, TextHAlignment::CENTER, TextVAlignment::TOP);
	label_start->setAnchorPoint(Point(0.5, 0.5));
	this->addChild(label_start, 1);
	auto menustart = Menu::create(tryagain, NULL);
	menustart->setPosition(Vec2(visibleSize.width / 4, visibleSize.height / 3));
	this->addChild(menustart);
	label_start->setPosition(Vec2(visibleSize.width / 4, visibleSize.height / 3));


	auto endgame = MenuItemImage::create(endnormal, endselected, CC_CALLBACK_1(End::gameover, this));
	endgame->setScale(visibleSize.height/endgame->getContentSize().height/10);
	auto label_end = Label::create("ExitGame", "verdana", 30, Size::ZERO, TextHAlignment::CENTER, TextVAlignment::TOP);
	label_end->setAnchorPoint(Point(0.5, 0.5));
	this->addChild(label_end, 1);
	auto menuend = Menu::create(endgame, NULL);
	menuend->setPosition(Vec2(visibleSize.width *3 / 4, visibleSize.height / 3));
	this->addChild(menuend);
	label_end->setPosition(Vec2(visibleSize.width * 3 / 4, visibleSize.height / 3));

	return true;
}

void End::gameover(Ref *pSender)
{
	Director::getInstance()->end();
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WP8) || (CC_TARGET_PLATFORM == CC_PLATFORM_WINRT)
	return;
#endif
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
	exit(0);
#endif
}

void End::gameagain(Ref *pSender)
{
	Director::getInstance()->replaceScene(GameScene::createScene(Color4B::GRAY));
}

void End::addBac()
{
	bac = Sprite::create(bac_end);
	bac->setPosition(Vec2(visibleSize.width/2,visibleSize.height/2));
	bac->setScaleX(visibleSize.width / bac->getContentSize().width);
	bac->setScaleY(visibleSize.height / bac->getContentSize().height);
	this->addChild(bac);
}

void End::addLabel()
{
	label = LabelTTF::create("Game Over","verdana",50);
	label->setPosition(Vec2(visibleSize.width / 2,visibleSize.height *3/4 ));
	this->addChild(label,1);
}

void End::addGrade()
{
	auto label_grade = LabelTTF::create(StringUtils::format("%d",grade),"verdana",30);
	label_grade->setPosition(Vec2(visibleSize.width / 2 +30+ label_grade->getContentSize().width / 2,visibleSize.height / 2));
	label_grade->setScale(visibleSize.width / label_grade->getContentSize().width / 30);
	this->addChild(label_grade,1);//grade done

	auto label_msg = LabelTTF::create("Score:", "verdana", 40);
	label_msg->setPosition(Vec2(visibleSize.width / 2-label_msg->getContentSize().width / 2,visibleSize.height / 2));
	this->addChild(label_msg,1);
}
