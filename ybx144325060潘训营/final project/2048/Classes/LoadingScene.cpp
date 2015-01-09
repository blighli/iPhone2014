#include "LoadingScene.h"
#include "SimpleAudioEngine.h"
#include "GameScene.h"
using namespace cocos2d;
using namespace CocosDenshion;

Scene* LoadingScene::createScene()
{
	auto scene = Scene::create();
	auto layer = LoadingScene::create();
	scene->addChild(layer);
	return scene;
}
bool LoadingScene::init() 
{
	if (Layer::init())
	{
		// add background to current scene
		LayerColor *bkGround = LayerColor::create(Color4B(0, 255, 255, 255));
		this->addChild(bkGround);
		LabelTTF *logo = LabelTTF::create("tashaxing's 2048", "Arial", 30);
		logo->setColor(Color3B(255, 255, 0));
		bkGround->addChild(logo);
		logo->setPosition(bkGround->getContentSize().width / 2, bkGround->getContentSize().height / 2);
		//添加音频预加载回调，注意，只有layer才能用schedule，scene不行
		this->scheduleOnce(schedule_selector(LoadingScene::loadingCallBack), 0);
		return true;
	}
	else
	{
		return false;
	}
}

void LoadingScene::loadingCallBack(float dt)
{
	SimpleAudioEngine::getInstance()->preloadEffect("get.mp3");//预加载音频
	SimpleAudioEngine::getInstance()->preloadEffect("gamewin.mp3");
	SimpleAudioEngine::getInstance()->preloadEffect("gameover.mp3");
	//跳转到游戏场景
	auto nextScene = GameScene::createScene();
	TransitionScene *transition = TransitionMoveInR::create(1, nextScene);
	Director::getInstance()->replaceScene(transition);
}
