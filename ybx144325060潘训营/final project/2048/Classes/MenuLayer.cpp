#include "MenuLayer.h"
USING_NS_CC;
MenuLayer* MenuLayer::create(const Color4B& color)
{
	MenuLayer *layer = new MenuLayer();
	if (layer&&layer->initWithColor(color))
	{
		layer->autorelease();
		return layer;
	}
	CC_SAFE_RELEASE(layer);
	return NULL;
}
bool MenuLayer::initWithColor(const Color4B& color)
{
	if (!LayerColor::initWithColor(color))
		return false;
	//��ӿյĴ�����������ֹ������Ӧ���ݵ��ײ�
	auto listener = EventListenerTouchOneByOne::create();
	listener->onTouchBegan = CC_CALLBACK_2(MenuLayer::onTouchBegan, this);
	listener->onTouchEnded = CC_CALLBACK_2(MenuLayer::onTouchEnded, this);
	_eventDispatcher->addEventListenerWithSceneGraphPriority(listener, this);
	//��û�����¼�
	listener->setSwallowTouches(true);
	return true;
}

bool MenuLayer::onTouchBegan(Touch *touch, Event *event)
{
	return true;
}

void MenuLayer::onTouchEnded(Touch *touch, Event *event)
{

}