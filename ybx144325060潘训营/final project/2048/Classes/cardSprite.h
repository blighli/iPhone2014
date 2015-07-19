#pragma once
#include "cocos2d.h"
USING_NS_CC;
class CardSprite :public Sprite
{
public:
	//创建三部曲
	static CardSprite* createCard(int num, int cardWidth, int cardHeight, float px, float py);
	virtual bool init();
	CREATE_FUNC(CardSprite);

	void setNumber(int num);
	int getNumber();
	LayerColor* getCardLayer();
private:
	int number;
	void cardInit(int num, int cardWidth, int cardHeight, float px, float py);
	LabelTTF *cardLabel;
	LayerColor *cardBgColour;
};