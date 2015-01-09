#pragma once
#include "cocos2d.h"
class LoadingScene : public cocos2d::Layer
{
public:
	static cocos2d::Scene* createScene();
	virtual bool init();
	CREATE_FUNC(LoadingScene);
	void loadingCallBack(float dt); //加载声音回调函数
};