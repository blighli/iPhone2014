#include "cardSprite.h"
bool CardSprite::init()
{
	//��׼init
	if (!Sprite::init())
		return false;
	else
		return true;
}

//��ʼ����Ƭ�����֣��ߴ磬����
void CardSprite::cardInit(int num, int cardWidth, int cardHeight, float px, float py) 
{
	number = num;
	cardBgColour = LayerColor::create(Color4B(200, 190, 180, 255), cardWidth - 5, cardHeight - 5);
	cardBgColour->setPosition(Point(px, py));
	if (number > 0) //��������֣�����ʾ����
	{
		cardLabel = LabelTTF::create(String::createWithFormat("%d", number)->getCString(), "Arial", 50);
		//��Ϊ�Ǽ��뵽���ڵ��У����Դ˴����������
		cardLabel->setPosition(cardBgColour->getContentSize().width / 2, cardBgColour->getContentSize().height / 2);
		cardBgColour->addChild(cardLabel); //�����ֱ�ǩ���뵽��Ƭ��

	}
	else    //�������ǿտ�Ƭ
	{
		cardLabel = LabelTTF::create("", "Arial", 50);
		cardLabel->setPosition(cardBgColour->getContentSize().width / 2, cardBgColour->getContentSize().height / 2);
		cardBgColour->addChild(cardLabel);
	}
	this->addChild(cardBgColour);  //����Ƭ����뵽��Ƭ����
}

//����һ����Ƭ�����ָ��
CardSprite* CardSprite::createCard(int num, int cardWidth, int cardHeight, float px, float py)
{
	CardSprite *card = new CardSprite();
	if (!card->init())
	{
		CC_SAFE_RELEASE(card);
		return NULL;
	}
	card->autorelease();  //����Ϊ�Զ�����
	card->cardInit(num, cardWidth, cardHeight, px, py);
	return card;
}

//���ÿ�Ƭ������
void CardSprite::setNumber(int num)
{
	number = num;
	//���ݲ�ͬ�����ַ�Χ��ʾ��ͬ����ɫ
	if (number >= 0 && number < 16)
	{
		cardLabel->setFontSize(50);
	}
	if (number >= 16 && number < 128)
	{
		cardLabel->setFontSize(40);
	}
	if (number >= 128 && number < 1024)
	{
		cardLabel->setFontSize(30);
	}
	if (number >= 1024)
	{
		cardLabel->setFontSize(20);
	}
	if (number == 0)
	{
		cardBgColour->setColor(Color3B(200, 190, 180));
	}
	if (number == 2)
	{
		cardBgColour->setColor(Color3B(240, 230, 220));
	}
	if (number == 4)
	{
		cardBgColour->setColor(Color3B(51, 153, 51));
	}
	if (number == 8){
		cardBgColour->setColor(Color3B(255, 153, 102));
	}
	if (number == 16)
	{
		cardBgColour->setColor(Color3B(153, 204, 153));
	}
	if (number == 32)
	{
		cardBgColour->setColor(Color3B(153, 204, 255));
	}
	if (number == 64)
	{
		cardBgColour->setColor(Color3B(255, 204, 204));
	}
	if (number == 128)
	{
		cardBgColour->setColor(Color3B(204, 102, 0));
	}
	if (number == 256)
	{
		cardBgColour->setColor(Color3B(153, 204, 51));
	}
	if (number == 512)
	{
		cardBgColour->setColor(Color3B(255, 102, 102));
	}
	if (number == 1024)
	{
		cardBgColour->setColor(Color3B(204, 204, 255));
	}
	if (number == 2048)
	{
		cardBgColour->setColor(Color3B(255, 204, 00));
	}

	if (number > 0)  //�����ִ���0ʱ����ʾ����
		cardLabel->setString(String::createWithFormat("%d", number)->getCString());
	else  //������ʾ��
		cardLabel->setString("");
}

//��ÿ�Ƭ����
int CardSprite::getNumber()
{
	return number;
}

//��ÿ�Ƭ��
LayerColor* CardSprite::getCardLayer()
{
	return cardBgColour;
}