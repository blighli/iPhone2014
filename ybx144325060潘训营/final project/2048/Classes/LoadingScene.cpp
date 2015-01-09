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
		//�����ƵԤ���ػص���ע�⣬ֻ��layer������schedule��scene����
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
	SimpleAudioEngine::getInstance()->preloadEffect("get.mp3");//Ԥ������Ƶ
	SimpleAudioEngine::getInstance()->preloadEffect("gamewin.mp3");
	SimpleAudioEngine::getInstance()->preloadEffect("gameover.mp3");
	//��ת����Ϸ����
	auto nextScene = GameScene::createScene();
	TransitionScene *transition = TransitionMoveInR::create(1, nextScene);
	Director::getInstance()->replaceScene(transition);
}
