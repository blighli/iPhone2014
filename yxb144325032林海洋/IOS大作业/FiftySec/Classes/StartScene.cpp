#include "StartScene.h"
#include "GameScene.h"

Scene *StartScene::createScene()
{
	auto scene = Scene::create();
	auto lay = StartScene::create();
	scene->addChild(lay);
	return scene;
}

bool StartScene::init()
{
	Layer::init();

	visibleSize = Director::getInstance()->getVisibleSize();
	origin = Director::getInstance()->getVisibleOrigin();
	
	//add bac
	addbac();
    

	//add label
	auto label_showmsg = Label::create("Who Can Hold On 50sec", "verdana", 40, Size::ZERO, TextHAlignment::LEFT, TextVAlignment::TOP);
	label_showmsg->setPosition(Vec2(visibleSize.width / 2,visibleSize.height *3 / 4));
	this->addChild(label_showmsg);

	//startbutton
	auto startgame = MenuItemImage::create(startnormal, startselected,CC_CALLBACK_1(StartScene::gamestart,this));
	startgame->setScale(visibleSize.height / startgame->getContentSize().height / 10);
	auto label_start = Label::create("StartGame", "verdana", 30, Size::ZERO, TextHAlignment::CENTER, TextVAlignment::TOP);
	label_start->setAnchorPoint(Point(0.5,0.5));
	this->addChild(label_start,1);
	auto menustart = Menu::create(startgame,NULL);
	menustart->setPosition(Vec2(visibleSize.width / 2,visibleSize.height / 2));
	this->addChild(menustart);
	label_start->setPosition(Vec2(visibleSize.width / 2, visibleSize.height / 2));

	//exitgame button
	auto endgame = MenuItemImage::create(endnormal, endselected, CC_CALLBACK_1(StartScene::gameover, this));
	endgame->setScale(visibleSize.height / endgame->getContentSize().height / 10);
	auto label_end = Label::create("ExitGame", "verdana", 30, Size::ZERO, TextHAlignment::CENTER, TextVAlignment::TOP);
	label_end->setAnchorPoint(Point(0.5, 0.5));
	this->addChild(label_end,1);
	auto menuend = Menu::create(endgame, NULL);
	menuend->setPosition(Vec2(visibleSize.width / 2,visibleSize.height/2 - label_end->getContentSize().height*3));
	this->addChild(menuend);
	label_end->setPosition(Vec2(visibleSize.width / 2, visibleSize.height / 2 - label_end->getContentSize().height * 3));
	return true;
}

void StartScene::gamestart(Ref* pSender)
{
	Director::getInstance()->replaceScene(GameScene::createScene(Color4B::GRAY));
}

void StartScene::gameover(Ref *pSender)
{
	Director::getInstance()->end();
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WP8) || (CC_TARGET_PLATFORM == CC_PLATFORM_WINRT)
	return;
#endif

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
	exit(0);
#endif
}
void StartScene::addbac()
{
	bac = Sprite::create(bac_start);
	bac->setPosition(Vec2(visibleSize.width / 2,visibleSize.height / 2));
	bac->setScaleX(visibleSize.width / bac->getContentSize().width);
	bac->setScaleY(visibleSize.height / bac->getContentSize().height);
	this->addChild(bac,0);
}
