/*
*game:2048
*author:tashaxing
*time:2014/10/12
*/
#include "GameScene.h"
#include "SimpleAudioEngine.h"
using namespace cocos2d;
using namespace CocosDenshion;
Scene* GameScene::createScene()
{
	auto scene = Scene::create();
	auto layer = GameScene::create();
	scene->addChild(layer);
	return scene;
}

bool GameScene::init()
{
	if (!Layer::init())
		return false;
	//�����Ļ�ߴ��ԭ��
	Size visibleSize = Director::getInstance()->getVisibleSize();
	Vec2 origin = Director::getInstance()->getVisibleOrigin();
    //��ӱ���
	auto gameBkGround = LayerColor::create(Color4B(180, 170, 160, 255));
	this->addChild(gameBkGround);
	//��ӱ���
	auto title = LabelTTF::create("My2048", "Arial", 60);
	title->setColor(Color3B(255, 255, 153));
	title->setPosition(Point(visibleSize.width / 2, visibleSize.height - 50));
	this->addChild(title);
	//����restart��ť  
	restartBtn = LabelTTF::create("Restart", "Arial", 40);
	restartBtn->setColor(Color3B(204, 255, 253));
	restartBtn->setPosition(Point(visibleSize.width / 2, visibleSize.height - 110));
	this->addChild(restartBtn);
	//��������л���ť
	//��ʼ����ȡ��÷�����������������һ������Ӧ�õĻ�xml��û���κ�ֵ����������Ļ᷵��0��false
	sound = UserDefault::getInstance()->getBoolForKey("SOUND");
	if (sound)
		isSoundBtn = LabelTTF::create("Sound On", "Arial", 40);
	else
		isSoundBtn = LabelTTF::create("Sound Off", "Arial", 40);
	isSoundBtn->setColor(Color3B(204, 255, 253));
	isSoundBtn->setPosition(Point(visibleSize.width / 2, 50));
	this->addChild(isSoundBtn);

	//������Ϸ����  
	auto slabel = LabelTTF::create("Score", "Arial", 30);
	slabel->setPosition(Point(visibleSize.width / 5, visibleSize.height - 150));
	this->addChild(slabel);
    score = 0;
    scoreLabel = LabelTTF::create("0", "Arial", 30);
	scoreLabel->setColor(Color3B(0, 255, 37));
	scoreLabel->setPosition(Point(visibleSize.width / 2+30, visibleSize.height - 150));
	this->addChild(scoreLabel);
	bestScore = UserDefault::getInstance()->getIntegerForKey("BEST");
	

	//��ʼ����Ƭ
	createCardArr(visibleSize);
	randomCreateCard();
	randomCreateCard();

	

	//��Ӵ�������
	auto listener = EventListenerTouchOneByOne::create();
	listener->onTouchBegan = CC_CALLBACK_2(GameScene::onTouchBegan, this);
	listener->onTouchEnded = CC_CALLBACK_2(GameScene::onTouchEnded, this);
	_eventDispatcher->addEventListenerWithSceneGraphPriority(listener, this);
	return true;
}

void GameScene::restart(Ref* sender)
{
	//ת�������¿�ʼ��Ϸ
	Director::getInstance()->replaceScene(TransitionFade::create(0.7f, GameScene::createScene()));
}

bool GameScene::onTouchBegan(Touch *touch, Event *event)
{
	gettimeofday(&tv, NULL); //��¼��ǰʱ��
	startPt = touch->getLocation(); //���濪ʼ������
	//�ж������������restart��ť�����������¿�ʼ
	if (restartBtn->getBoundingBox().containsPoint(restartBtn->convertToNodeSpace(touch->getLocation())))
		Director::getInstance()->replaceScene(TransitionFade::create(0.7f, GameScene::createScene()));
	//��������
	if (isSoundBtn->getBoundingBox().containsPoint(isSoundBtn->convertToNodeSpace(touch->getLocation())))
	{
		sound = !sound;
		UserDefault::getInstance()->setBoolForKey("SOUND", sound);
		if (sound)
			isSoundBtn->setString("Sound On");
		else
			isSoundBtn->setString("Sound Off");
	}
	return true;
}

void GameScene::onTouchEnded(Touch *touch, Event *event)
{
	timeval tv_end;
	gettimeofday(&tv_end, NULL);
	if (tv_end.tv_sec - tv.tv_sec > 3)
	{
		//�������ţ�����������ϷӮ��
		cardArr[0][3]->setNumber(2048);
		checkGameWin();
	}

	auto endPt = touch->getLocation();  //��ô���������
	offsetX = endPt.x - startPt.x;  //����ƫ��
	offsetY = endPt.y - startPt.y;
	bool isTouch = false; 
	if (abs(offsetX) > abs(offsetY))  //�ж�Ϊ����
	{
		if (offsetX < -5)
			isTouch = moveLeft();
		else if (offsetX > 5)
			isTouch = moveRight();
	}
	else
	{
		if (offsetY > 5)   //ע����������������Ū��
			isTouch = moveDown();
		else if (offsetY<-5)
			isTouch = moveUp();
	}
	if (isTouch)  //��������ɹ����ж�
	{
		scoreLabel->setString(String::createWithFormat("%d", score)->getCString());
		//��������˳������
		checkGameWin();
		randomCreateCard();
		checkGameOver();
	}
}

void GameScene::createCardArr(Size size)
{
	int space = 5; //��Ƭ��ļ��
	int cardSize = (size.width - 4 * space) / 4;
	
	//������Ƭ����
	for (int i = 0; i < 4; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			//���������12������������size.height/6
			//��������½�������Ϊ������Ϊ��
			CardSprite *card = CardSprite::createCard(0, cardSize, cardSize, cardSize*i + 12, cardSize*j + 12 + size.height / 6);
			this->addChild(card);  //һ��Ҫ��card��ӵ��ӽڵ������Ⱦ����
			cardArr[i][j] = card;  //�浽��Ƭ����
		}
	}

	//������ʱ��Ƭ�������ڶ�����ÿ��������Ƭ��Ӧһ��ʵ�ʿ�Ƭ�Ķ��������Ǹ�����,���Ҷ������ڿ�Ƭ��֮�ϣ����Ժ���룬Ҳ��������addchild���
	for (int i = 0; i < 4; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			//���������12������������size.height/6
			CardSprite *card = CardSprite::createCard(0, cardSize, cardSize, cardSize*i + 12, cardSize*j + 12 + size.height / 6);
			this->addChild(card);
			cardArrAction[i][j] = card;
			//һ��ʼ�����ȫ�����
			auto hide = Hide::create();
			cardArrAction[i][j]->getCardLayer()->runAction(hide);
		}
	}
}

void GameScene::randomCreateCard()
{
	//�����λ�����ɿ�Ƭ
	int row = CCRANDOM_0_1() * 4;
	int col = CCRANDOM_0_1() * 4;
	if (cardArr[row][col]->getNumber() > 0)  //��������֣���ݹ����
		randomCreateCard();
	else
	{
		cardArr[row][col]->setNumber(CCRANDOM_0_1() * 10 < 1 ? 4 : 2); //��10%�ļ�������4
		//�ö���Ч������
		auto action = Sequence::createWithTwoActions(ScaleTo::create(0, 0), ScaleTo::create(0.3f, 1));  //��0.3���ڴ�С���ŵ���
		cardArr[row][col]->getCardLayer()->runAction(action);  //�ÿ�Ƭ�Ĳ�����ǿ�Ƭ���鱾����������Ϊ��ʹ�þֲ���������
	}
}

//���󻬶���Ϸ�߼���������������
bool GameScene::moveLeft()
{
	//�Ƿ����ƶ����߼����������û���κ��ƶ�������Ҫ������ɿ�Ƭ��Ҳ������Ӯ�䣬��һ��ܹؼ�����������׳�bug
	bool moved = false;
	//�����ƶ��Ĳ������
	auto cardSize = (Director::getInstance()->getVisibleSize().width - 5 * 4) / 4;
	//y��ʾ�б�ţ�x��ʾ�б��
	for (int y = 0; y < 4; y++)  //�������б��������Ȳ���
	{
		for (int x = 0; x < 4; x++)   //�ڲ���N^2���Ӷȵ�����ð������
		{
			for (int x1 = x + 1; x1 < 4; x1++)
			{
				if (cardArr[x1][y]->getNumber()>0)  //x�ұߵĿ�Ƭ�����ֲŶ���
				{
					if (cardArr[x][y]->getNumber() == 0)
					{
						//ר��Ūһ�������㿨Ƭʵ�ֶ�λ�����֡��ƶ�������ϵ�ж���
						auto place = Place::create(Point(cardSize*x1 + 12, cardSize*y + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x1][y]->setNumber(cardArr[x1][y]->getNumber());  //ÿ�ζ����°Ѷ�����Ƭ���¶�λ��ʵ�ʶ�Ӧ�Ŀ�Ƭλ�ã���������ͬ������
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(-cardSize*(x1 - x), 0));  //ע���ƶ��ľ���
						auto hide = Hide::create();
						cardArrAction[x1][y]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));		
						//���xλ���ǿտ�Ƭ���Ͱ�x1��Ƭ�Ƶ�x����x1����ɿտ�Ƭ
						cardArr[x][y]->setNumber(cardArr[x1][y]->getNumber());
						cardArr[x1][y]->setNumber(0);
						x--;  //��ɨ��һ�飬ȷ�����н����ȷ
						moved = true;
					}
					else if (cardArr[x][y]->getNumber() == cardArr[x1][y]->getNumber())
					{
						auto place = Place::create(Point(cardSize*x1 + 12, cardSize*y + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x1][y]->setNumber(cardArr[x1][y]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(-cardSize*(x1 - x), 0));  //ע���ƶ��ľ���
						auto hide = Hide::create();
						cardArrAction[x1][y]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//���xλ�÷ǿգ�����x1��������ͬ�����2
						cardArr[x][y]->setNumber(cardArr[x][y]->getNumber() * 2);
						cardArr[x1][y]->setNumber(0);
						
						//���ֺϲ�����
						auto merge = Sequence::create(ScaleTo::create(0.1f, 1.2f), ScaleTo::create(0.1f, 1.0f), NULL);
						cardArr[x][y]->getCardLayer()->runAction(merge);
						
						score += cardArr[x][y]->getNumber();
						
						//���ŵ÷�����
						if (sound)
							SimpleAudioEngine::getInstance()->playEffect("get.mp3");

						moved = true;
					}
					break;   //�˴�break��ֹ����������2��bug
				}
			}
		}
	}
	return moved;
}

bool GameScene::moveRight()
{
	bool moved = false;
	//�����ƶ��Ĳ������
	auto cardSize = (Director::getInstance()->getVisibleSize().width - 5 * 4) / 4;
	//y��ʾ�б�ţ�x��ʾ�б��
	for (int y = 0; y < 4; y++)  //�������б��������Ȳ���
	{
		for (int x = 3; x >=0; x--)   //�ڲ���N^2���Ӷȵ�����ð������
		{
			for (int x1 = x -1; x1 >= 0; x1--)
			{
				if (cardArr[x1][y]->getNumber()>0)  //x��ߵĿ�Ƭ�����ֲŶ���
				{
					if (cardArr[x][y]->getNumber() == 0)
					{
						auto place = Place::create(Point(cardSize*x1 + 12, cardSize*y + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x1][y]->setNumber(cardArr[x1][y]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(-cardSize*(x1 - x), 0));  //ע���ƶ��ľ���
						auto hide = Hide::create();
						cardArrAction[x1][y]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//���xλ���ǿտ�Ƭ���Ͱ�x1��Ƭ�Ƶ�x����x1����ɿտ�Ƭ
						cardArr[x][y]->setNumber(cardArr[x1][y]->getNumber());
						cardArr[x1][y]->setNumber(0);
						x++;
						moved = true;
					}
					else if (cardArr[x][y]->getNumber() == cardArr[x1][y]->getNumber())
					{
						auto place = Place::create(Point(cardSize*x1 + 12, cardSize*y + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x1][y]->setNumber(cardArr[x1][y]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(-cardSize*(x1 - x), 0));  //ע���ƶ��ľ��룬�˴������Ϊ��
						auto hide = Hide::create();
						cardArrAction[x1][y]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//���xλ�÷ǿգ�����x1��������ͬ�����2
						cardArr[x][y]->setNumber(cardArr[x][y]->getNumber() * 2);
						cardArr[x1][y]->setNumber(0);

						auto merge = Sequence::create(ScaleTo::create(0.1f, 1.2f), ScaleTo::create(0.1f, 1.0f), NULL);
						cardArr[x][y]->getCardLayer()->runAction(merge);

						score += cardArr[x][y]->getNumber();
						if (sound)
							SimpleAudioEngine::getInstance()->playEffect("get.mp3");
						moved = true;
					}
					break;   //�˴�break��ֹ����������2��bug
				}
			}
		}
	}
	return moved;
}

bool GameScene::moveUp()   //����ġ��ϡ����߼���������ֵС�ķ�������Ļ��ʵ�������¶�
{
	bool moved=false;
	//�����ƶ��Ĳ������
	auto cardSize = (Director::getInstance()->getVisibleSize().width - 5 * 4) / 4;
	//y��ʾ�б�ţ�x��ʾ�б��
	for (int x = 0; x < 4; x++)  //�������б��������Ȳ���
	{
		for (int y = 0; y < 4; y++)   //�ڲ���N^2���Ӷȵ�����ð������
		{
			for (int y1 = y + 1; y1 < 4; y1++)
			{
				if (cardArr[x][y1]->getNumber()>0)  //x�±ߵĿ�Ƭ�����ֲŶ���
				{
					if (cardArr[x][y]->getNumber() == 0)
					{
						auto place = Place::create(Point(cardSize*x + 12, cardSize*y1 + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x][y1]->setNumber(cardArr[x][y1]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(0 ,- cardSize*(y1 - y)));  //ע���ƶ��ľ���
						auto hide = Hide::create();
						cardArrAction[x][y1]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));
						
						//���xλ���ǿտ�Ƭ���Ͱ�x1��Ƭ�Ƶ�x����x1����ɿտ�Ƭ
						cardArr[x][y]->setNumber(cardArr[x][y1]->getNumber());
						cardArr[x][y1]->setNumber(0);
						y--;
						moved = true;
					}
					else if (cardArr[x][y]->getNumber() == cardArr[x][y1]->getNumber())
					{
						auto place = Place::create(Point(cardSize*x + 12, cardSize*y1 + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x][y1]->setNumber(cardArr[x][y1]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(0, -cardSize*(y1 - y)));  //ע���ƶ��ľ���
						auto hide = Hide::create();
						cardArrAction[x][y1]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//���xλ�÷ǿգ�����x1��������ͬ�����2
						cardArr[x][y]->setNumber(cardArr[x][y]->getNumber() * 2);
						cardArr[x][y1]->setNumber(0);

						auto merge = Sequence::create(ScaleTo::create(0.1f, 1.2f), ScaleTo::create(0.1f, 1.0f), NULL);
						cardArr[x][y]->getCardLayer()->runAction(merge);

						score += cardArr[x][y]->getNumber();
						if (sound)
							SimpleAudioEngine::getInstance()->playEffect("get.mp3");
						moved = true;
					}
					break;   //�˴�break��ֹ����������2��bug
				}
			}
		}
	}
	return moved;
}

bool GameScene::moveDown()   //����ġ��¡����߼���������ֵС�ķ�������Ļ��ʵ�������϶�
{
	bool moved=false;
	//�����ƶ��Ĳ������
	auto cardSize = (Director::getInstance()->getVisibleSize().width - 5 * 4) / 4;
	//y��ʾ�б�ţ�x��ʾ�б��
	for (int x = 0; x < 4; x++)  //�������б��������Ȳ���
	{
		for (int y = 3; y >= 0; y--)   //�ڲ���N^2���Ӷȵ�����ð������
		{
			for (int y1 = y - 1; y1 >= 0; y1--)
			{
				if (cardArr[x][y1]->getNumber()>0)  //x�ϱߵĿ�Ƭ�����ֲŶ���
				{
					if (cardArr[x][y]->getNumber() == 0)
					{
						auto place = Place::create(Point(cardSize*x + 12, cardSize*y1 + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x][y1]->setNumber(cardArr[x][y1]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(0, -cardSize*(y1 - y)));  //ע���ƶ��ľ���
						auto hide = Hide::create();
						cardArrAction[x][y1]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//���xλ���ǿտ�Ƭ���Ͱ�x1��Ƭ�Ƶ�x����x1����ɿտ�Ƭ
						cardArr[x][y]->setNumber(cardArr[x][y1]->getNumber());
						cardArr[x][y1]->setNumber(0);
						y++;
						moved = true;
					}
					else if (cardArr[x][y]->getNumber() == cardArr[x][y1]->getNumber())
					{
						auto place = Place::create(Point(cardSize*x + 12, cardSize*y1 + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x][y1]->setNumber(cardArr[x][y1]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(0, -cardSize*(y1 - y)));  //ע���ƶ��ľ���
						auto hide = Hide::create();
						cardArrAction[x][y1]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//���xλ�÷ǿգ�����x1��������ͬ�����2
						cardArr[x][y]->setNumber(cardArr[x][y]->getNumber() * 2);
						cardArr[x][y1]->setNumber(0);

						auto merge = Sequence::create(ScaleTo::create(0.1f, 1.2f), ScaleTo::create(0.1f, 1.0f), NULL);
						cardArr[x][y]->getCardLayer()->runAction(merge);

						score += cardArr[x][y]->getNumber();
						if (sound)
							SimpleAudioEngine::getInstance()->playEffect("get.mp3");
						moved = true;
					}
					break;   //�˴�break��ֹ����������2��bug
				}
			}
		}
	}
	return moved;
}



void GameScene::checkGameWin()
{
	bool isWin = false;
	for (int i = 0; i < 4; i++)
		for (int j = 0; j < 4; j++)
			if (2048 == cardArr[i][j]->getNumber())
				isWin = true;
	if (isWin)
	{
		//������Ч
		if (sound)
			SimpleAudioEngine::getInstance()->playEffect("gamewin.mp3");
		//��һ��2048��Ϸ����Ӯ��
		/*��ʼ���˵���*/
		menuLayer = MenuLayer::create(Color4B(0, 0, 0, 100));
		this->addChild(menuLayer);
		auto menuSize = menuLayer->getContentSize();
		//��ӱ���
		auto menuTitle = LabelTTF::create("YOU WIN", "Arial", 30);
		menuTitle->setPosition(menuSize.width / 2, menuSize.height / 2 + 50);
		menuLayer->addChild(menuTitle);
		//��ӵ�ǰ����
		auto menuscoreLabel = LabelTTF::create(String::createWithFormat("current: %d", score)->getCString(), "Arial", 20);
		menuscoreLabel->setPosition(menuSize.width / 2, menuSize.height / 2);
		menuLayer->addChild(menuscoreLabel);
		//�����÷���
		bestScore = UserDefault::getInstance()->getIntegerForKey("BEST");
		if (score > bestScore)
		{
			bestScore = score;
			UserDefault::getInstance()->setIntegerForKey("BEST", bestScore);
		}
		auto menuBestscoreLabel = LabelTTF::create(String::createWithFormat("best: %d", bestScore)->getCString(), "Arial", 20);
		menuBestscoreLabel->setPosition(menuSize.width / 2, menuSize.height / 2 - 30);
		menuLayer->addChild(menuBestscoreLabel);
		MenuItemFont::setFontName("Arial");
		MenuItemFont::setFontSize(25);
		auto menuItemRestart = MenuItemFont::create("Restart", this, menu_selector(GameScene::restart));
		menuItemRestart->setColor(Color3B(255, 255, 0));
		auto menu = Menu::create(menuItemRestart, NULL);
		menuLayer->addChild(menu);
		menu->setPosition(Point(menuSize.width / 2, menuSize.height / 2 - 80));
	}
}

void GameScene::checkGameOver()
{
	bool isGameOver = true;
	//�����������Ϸ����
	for (int j = 0; j < 4; j++)
	{
		for (int i = 0; i < 4; i++)
		{
			if ((cardArr[i][j]->getNumber()==0)||
				(i>0 && cardArr[i][j]->getNumber() == cardArr[i - 1][j]->getNumber()) ||
				(i<3 && cardArr[i][j]->getNumber() == cardArr[i + 1][j]->getNumber()) ||
				(j>0 && cardArr[i][j]->getNumber() == cardArr[i][j - 1]->getNumber()) ||
				(j<3 && cardArr[i][j]->getNumber() == cardArr[i][j + 1]->getNumber()))
			{
				isGameOver = false;
			}
		}
	}
	//������Ϸ����
	if (isGameOver)
	{
		if (sound)
			SimpleAudioEngine::getInstance()->playEffect("gameover.mp3");
		/*��ʼ���˵���*/
		menuLayer = MenuLayer::create(Color4B(0, 0, 0, 100));
		this->addChild(menuLayer);
		auto menuSize = menuLayer->getContentSize();
		//��ӱ���
		auto menuTitle = LabelTTF::create("GAME OVER", "Arial", 30);
		menuTitle->setPosition(menuSize.width / 2, menuSize.height / 2 + 50);
		menuLayer->addChild(menuTitle);
		//��ӵ�ǰ����
		auto menuscoreLabel = LabelTTF::create(String::createWithFormat("current: %d", score)->getCString(), "Arial", 20);
		menuscoreLabel->setPosition(menuSize.width / 2, menuSize.height / 2);
		menuLayer->addChild(menuscoreLabel);
		//�����÷���
		bestScore = UserDefault::getInstance()->getIntegerForKey("BEST");
		if (score > bestScore)
		{
			bestScore = score;
			UserDefault::getInstance()->setIntegerForKey("BEST", bestScore);
		}
		auto menuBestscoreLabel = LabelTTF::create(String::createWithFormat("best: %d", bestScore)->getCString(), "Arial", 20);
		menuBestscoreLabel->setPosition(menuSize.width / 2, menuSize.height / 2 - 30);
		menuLayer->addChild(menuBestscoreLabel);
		MenuItemFont::setFontName("Arial");
		MenuItemFont::setFontSize(25);
		auto menuItemRestart = MenuItemFont::create("Restart", this, menu_selector(GameScene::restart));
		menuItemRestart->setColor(Color3B(255, 255, 0));
		auto menu = Menu::create(menuItemRestart, NULL);
		menuLayer->addChild(menu);
		menu->setPosition(Point(menuSize.width / 2, menuSize.height / 2 - 80));
	}
		
}