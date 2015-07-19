#pragma once
#include "cocos2d.h"
class MenuLayer :public cocos2d::LayerColor
{
public:
	static MenuLayer* create(const cocos2d::Color4B& color);
	virtual bool initWithColor(const cocos2d::Color4B& color);
	//触摸监听
	virtual bool onTouchBegan(cocos2d::Touch *touch, cocos2d::Event *event); //注意这里要加命名空间作用域cocos2d
	virtual void onTouchEnded(cocos2d::Touch *touch, cocos2d::Event *event);
};