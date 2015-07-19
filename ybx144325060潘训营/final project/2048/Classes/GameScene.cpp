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
	//获得屏幕尺寸和原点
	Size visibleSize = Director::getInstance()->getVisibleSize();
	Vec2 origin = Director::getInstance()->getVisibleOrigin();
    //添加背景
	auto gameBkGround = LayerColor::create(Color4B(180, 170, 160, 255));
	this->addChild(gameBkGround);
	//添加标题
	auto title = LabelTTF::create("My2048", "Arial", 60);
	title->setColor(Color3B(255, 255, 153));
	title->setPosition(Point(visibleSize.width / 2, visibleSize.height - 50));
	this->addChild(title);
	//加入restart按钮  
	restartBtn = LabelTTF::create("Restart", "Arial", 40);
	restartBtn->setColor(Color3B(204, 255, 253));
	restartBtn->setPosition(Point(visibleSize.width / 2, visibleSize.height - 110));
	this->addChild(restartBtn);
	//添加声音切换按钮
	//初始化获取最好分数和声音变量，第一次启动应用的话xml里没有任何值，所以下面的会返回0和false
	sound = UserDefault::getInstance()->getBoolForKey("SOUND");
	if (sound)
		isSoundBtn = LabelTTF::create("Sound On", "Arial", 40);
	else
		isSoundBtn = LabelTTF::create("Sound Off", "Arial", 40);
	isSoundBtn->setColor(Color3B(204, 255, 253));
	isSoundBtn->setPosition(Point(visibleSize.width / 2, 50));
	this->addChild(isSoundBtn);

	//加入游戏分数  
	auto slabel = LabelTTF::create("Score", "Arial", 30);
	slabel->setPosition(Point(visibleSize.width / 5, visibleSize.height - 150));
	this->addChild(slabel);
    score = 0;
    scoreLabel = LabelTTF::create("0", "Arial", 30);
	scoreLabel->setColor(Color3B(0, 255, 37));
	scoreLabel->setPosition(Point(visibleSize.width / 2+30, visibleSize.height - 150));
	this->addChild(scoreLabel);
	bestScore = UserDefault::getInstance()->getIntegerForKey("BEST");
	

	//初始化卡片
	createCardArr(visibleSize);
	randomCreateCard();
	randomCreateCard();

	

	//添加触摸监听
	auto listener = EventListenerTouchOneByOne::create();
	listener->onTouchBegan = CC_CALLBACK_2(GameScene::onTouchBegan, this);
	listener->onTouchEnded = CC_CALLBACK_2(GameScene::onTouchEnded, this);
	_eventDispatcher->addEventListenerWithSceneGraphPriority(listener, this);
	return true;
}

void GameScene::restart(Ref* sender)
{
	//转场，重新开始游戏
	Director::getInstance()->replaceScene(TransitionFade::create(0.7f, GameScene::createScene()));
}

bool GameScene::onTouchBegan(Touch *touch, Event *event)
{
	gettimeofday(&tv, NULL); //记录当前时间
	startPt = touch->getLocation(); //保存开始触摸点
	//判断如果触摸点在restart按钮区域内则重新开始
	if (restartBtn->getBoundingBox().containsPoint(restartBtn->convertToNodeSpace(touch->getLocation())))
		Director::getInstance()->replaceScene(TransitionFade::create(0.7f, GameScene::createScene()));
	//声音开关
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
		//开个后门，用来测试游戏赢了
		cardArr[0][3]->setNumber(2048);
		checkGameWin();
	}

	auto endPt = touch->getLocation();  //获得触摸结束点
	offsetX = endPt.x - startPt.x;  //计算偏移
	offsetY = endPt.y - startPt.y;
	bool isTouch = false; 
	if (abs(offsetX) > abs(offsetY))  //判断为方向
	{
		if (offsetX < -5)
			isTouch = moveLeft();
		else if (offsetX > 5)
			isTouch = moveRight();
	}
	else
	{
		if (offsetY > 5)   //注意这里的纵向坐标别弄反
			isTouch = moveDown();
		else if (offsetY<-5)
			isTouch = moveUp();
	}
	if (isTouch)  //如果滑动成功则判断
	{
		scoreLabel->setString(String::createWithFormat("%d", score)->getCString());
		//这三个的顺序不能乱
		checkGameWin();
		randomCreateCard();
		checkGameOver();
	}
}

void GameScene::createCardArr(Size size)
{
	int space = 5; //卡片间的间隔
	int cardSize = (size.width - 4 * space) / 4;
	
	//创建卡片矩阵
	for (int i = 0; i < 4; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			//最左边留白12，最下面留白size.height/6
			//坐标从左下角算起，右为正，上为正
			CardSprite *card = CardSprite::createCard(0, cardSize, cardSize, cardSize*i + 12, cardSize*j + 12 + size.height / 6);
			this->addChild(card);  //一定要把card添加到子节点才能渲染出来
			cardArr[i][j] = card;  //存到卡片矩阵
		}
	}

	//创建临时卡片矩阵，用于动画，每个动画卡片对应一个实际卡片的动画，这是个技巧,并且动画层在卡片层之上，所以后加入，也可以设置addchild层次
	for (int i = 0; i < 4; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			//最左边留白12，最下面留白size.height/6
			CardSprite *card = CardSprite::createCard(0, cardSize, cardSize, cardSize*i + 12, cardSize*j + 12 + size.height / 6);
			this->addChild(card);
			cardArrAction[i][j] = card;
			//一开始把这层全部因此
			auto hide = Hide::create();
			cardArrAction[i][j]->getCardLayer()->runAction(hide);
		}
	}
}

void GameScene::randomCreateCard()
{
	//在随机位置生成卡片
	int row = CCRANDOM_0_1() * 4;
	int col = CCRANDOM_0_1() * 4;
	if (cardArr[row][col]->getNumber() > 0)  //如果有数字，则递归调用
		randomCreateCard();
	else
	{
		cardArr[row][col]->setNumber(CCRANDOM_0_1() * 10 < 1 ? 4 : 2); //有10%的几率生成4
		//用动画效果生成
		auto action = Sequence::createWithTwoActions(ScaleTo::create(0, 0), ScaleTo::create(0.3f, 1));  //在0.3秒内从小缩放到大
		cardArr[row][col]->getCardLayer()->runAction(action);  //用卡片的层而不是卡片精灵本身做动作是为了使用局部坐标缩放
	}
}

//向左滑动游戏逻辑，其他方向类似
bool GameScene::moveLeft()
{
	//是否有移动的逻辑变量，如果没有任何移动，则不需要随机生成卡片，也不检验赢输，这一点很关键，否则很容易出bug
	bool moved = false;
	//计算移动的步进间距
	auto cardSize = (Director::getInstance()->getVisibleSize().width - 5 * 4) / 4;
	//y表示行标号，x表示列标号
	for (int y = 0; y < 4; y++)  //最外层的行遍历可以先不管
	{
		for (int x = 0; x < 4; x++)   //内部的N^2复杂度的类似冒泡排序
		{
			for (int x1 = x + 1; x1 < 4; x1++)
			{
				if (cardArr[x1][y]->getNumber()>0)  //x右边的卡片有数字才动作
				{
					if (cardArr[x][y]->getNumber() == 0)
					{
						//专门弄一个动画层卡片实现定位、显现、移动、隐藏系列动画
						auto place = Place::create(Point(cardSize*x1 + 12, cardSize*y + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x1][y]->setNumber(cardArr[x1][y]->getNumber());  //每次都重新把动画卡片重新定位到实际对应的卡片位置，并设置相同的数字
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(-cardSize*(x1 - x), 0));  //注意移动的距离
						auto hide = Hide::create();
						cardArrAction[x1][y]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));		
						//如果x位置是空卡片，就把x1卡片移到x处，x1处变成空卡片
						cardArr[x][y]->setNumber(cardArr[x1][y]->getNumber());
						cardArr[x1][y]->setNumber(0);
						x--;  //再扫描一遍，确保所有结果正确
						moved = true;
					}
					else if (cardArr[x][y]->getNumber() == cardArr[x1][y]->getNumber())
					{
						auto place = Place::create(Point(cardSize*x1 + 12, cardSize*y + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x1][y]->setNumber(cardArr[x1][y]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(-cardSize*(x1 - x), 0));  //注意移动的距离
						auto hide = Hide::create();
						cardArrAction[x1][y]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//如果x位置非空，且与x1处数字相同，则乘2
						cardArr[x][y]->setNumber(cardArr[x][y]->getNumber() * 2);
						cardArr[x1][y]->setNumber(0);
						
						//数字合并动画
						auto merge = Sequence::create(ScaleTo::create(0.1f, 1.2f), ScaleTo::create(0.1f, 1.0f), NULL);
						cardArr[x][y]->getCardLayer()->runAction(merge);
						
						score += cardArr[x][y]->getNumber();
						
						//播放得分声音
						if (sound)
							SimpleAudioEngine::getInstance()->playEffect("get.mp3");

						moved = true;
					}
					break;   //此处break防止出现连续乘2的bug
				}
			}
		}
	}
	return moved;
}

bool GameScene::moveRight()
{
	bool moved = false;
	//计算移动的步进间距
	auto cardSize = (Director::getInstance()->getVisibleSize().width - 5 * 4) / 4;
	//y表示行标号，x表示列标号
	for (int y = 0; y < 4; y++)  //最外层的行遍历可以先不管
	{
		for (int x = 3; x >=0; x--)   //内部的N^2复杂度的类似冒泡排序
		{
			for (int x1 = x -1; x1 >= 0; x1--)
			{
				if (cardArr[x1][y]->getNumber()>0)  //x左边的卡片有数字才动作
				{
					if (cardArr[x][y]->getNumber() == 0)
					{
						auto place = Place::create(Point(cardSize*x1 + 12, cardSize*y + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x1][y]->setNumber(cardArr[x1][y]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(-cardSize*(x1 - x), 0));  //注意移动的距离
						auto hide = Hide::create();
						cardArrAction[x1][y]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//如果x位置是空卡片，就把x1卡片移到x处，x1处变成空卡片
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
						auto move = MoveBy::create(0.1f, Point(-cardSize*(x1 - x), 0));  //注意移动的距离，此处算出来为正
						auto hide = Hide::create();
						cardArrAction[x1][y]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//如果x位置非空，且与x1处数字相同，则乘2
						cardArr[x][y]->setNumber(cardArr[x][y]->getNumber() * 2);
						cardArr[x1][y]->setNumber(0);

						auto merge = Sequence::create(ScaleTo::create(0.1f, 1.2f), ScaleTo::create(0.1f, 1.0f), NULL);
						cardArr[x][y]->getCardLayer()->runAction(merge);

						score += cardArr[x][y]->getNumber();
						if (sound)
							SimpleAudioEngine::getInstance()->playEffect("get.mp3");
						moved = true;
					}
					break;   //此处break防止出现连续乘2的bug
				}
			}
		}
	}
	return moved;
}

bool GameScene::moveUp()   //这里的“上”是逻辑上往坐标值小的方向，在屏幕上实际是往下动
{
	bool moved=false;
	//计算移动的步进间距
	auto cardSize = (Director::getInstance()->getVisibleSize().width - 5 * 4) / 4;
	//y表示行标号，x表示列标号
	for (int x = 0; x < 4; x++)  //最外层的列遍历可以先不管
	{
		for (int y = 0; y < 4; y++)   //内部的N^2复杂度的类似冒泡排序
		{
			for (int y1 = y + 1; y1 < 4; y1++)
			{
				if (cardArr[x][y1]->getNumber()>0)  //x下边的卡片有数字才动作
				{
					if (cardArr[x][y]->getNumber() == 0)
					{
						auto place = Place::create(Point(cardSize*x + 12, cardSize*y1 + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x][y1]->setNumber(cardArr[x][y1]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(0 ,- cardSize*(y1 - y)));  //注意移动的距离
						auto hide = Hide::create();
						cardArrAction[x][y1]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));
						
						//如果x位置是空卡片，就把x1卡片移到x处，x1处变成空卡片
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
						auto move = MoveBy::create(0.1f, Point(0, -cardSize*(y1 - y)));  //注意移动的距离
						auto hide = Hide::create();
						cardArrAction[x][y1]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//如果x位置非空，且与x1处数字相同，则乘2
						cardArr[x][y]->setNumber(cardArr[x][y]->getNumber() * 2);
						cardArr[x][y1]->setNumber(0);

						auto merge = Sequence::create(ScaleTo::create(0.1f, 1.2f), ScaleTo::create(0.1f, 1.0f), NULL);
						cardArr[x][y]->getCardLayer()->runAction(merge);

						score += cardArr[x][y]->getNumber();
						if (sound)
							SimpleAudioEngine::getInstance()->playEffect("get.mp3");
						moved = true;
					}
					break;   //此处break防止出现连续乘2的bug
				}
			}
		}
	}
	return moved;
}

bool GameScene::moveDown()   //这里的“下”是逻辑上往坐标值小的方向，在屏幕上实际是往上动
{
	bool moved=false;
	//计算移动的步进间距
	auto cardSize = (Director::getInstance()->getVisibleSize().width - 5 * 4) / 4;
	//y表示行标号，x表示列标号
	for (int x = 0; x < 4; x++)  //最外层的列遍历可以先不管
	{
		for (int y = 3; y >= 0; y--)   //内部的N^2复杂度的类似冒泡排序
		{
			for (int y1 = y - 1; y1 >= 0; y1--)
			{
				if (cardArr[x][y1]->getNumber()>0)  //x上边的卡片有数字才动作
				{
					if (cardArr[x][y]->getNumber() == 0)
					{
						auto place = Place::create(Point(cardSize*x + 12, cardSize*y1 + 12 + Director::getInstance()->getVisibleSize().height / 6));
						cardArrAction[x][y1]->setNumber(cardArr[x][y1]->getNumber());
						auto show = Show::create();
						auto move = MoveBy::create(0.1f, Point(0, -cardSize*(y1 - y)));  //注意移动的距离
						auto hide = Hide::create();
						cardArrAction[x][y1]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//如果x位置是空卡片，就把x1卡片移到x处，x1处变成空卡片
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
						auto move = MoveBy::create(0.1f, Point(0, -cardSize*(y1 - y)));  //注意移动的距离
						auto hide = Hide::create();
						cardArrAction[x][y1]->getCardLayer()->runAction(Sequence::create(place, show, move, hide, NULL));

						//如果x位置非空，且与x1处数字相同，则乘2
						cardArr[x][y]->setNumber(cardArr[x][y]->getNumber() * 2);
						cardArr[x][y1]->setNumber(0);

						auto merge = Sequence::create(ScaleTo::create(0.1f, 1.2f), ScaleTo::create(0.1f, 1.0f), NULL);
						cardArr[x][y]->getCardLayer()->runAction(merge);

						score += cardArr[x][y]->getNumber();
						if (sound)
							SimpleAudioEngine::getInstance()->playEffect("get.mp3");
						moved = true;
					}
					break;   //此处break防止出现连续乘2的bug
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
		//播放音效
		if (sound)
			SimpleAudioEngine::getInstance()->playEffect("gamewin.mp3");
		//有一个2048游戏就是赢了
		/*初始化菜单层*/
		menuLayer = MenuLayer::create(Color4B(0, 0, 0, 100));
		this->addChild(menuLayer);
		auto menuSize = menuLayer->getContentSize();
		//添加标题
		auto menuTitle = LabelTTF::create("YOU WIN", "Arial", 30);
		menuTitle->setPosition(menuSize.width / 2, menuSize.height / 2 + 50);
		menuLayer->addChild(menuTitle);
		//添加当前分数
		auto menuscoreLabel = LabelTTF::create(String::createWithFormat("current: %d", score)->getCString(), "Arial", 20);
		menuscoreLabel->setPosition(menuSize.width / 2, menuSize.height / 2);
		menuLayer->addChild(menuscoreLabel);
		//添加最好分数
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
	//以下情况则游戏继续
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
	//否则游戏结束
	if (isGameOver)
	{
		if (sound)
			SimpleAudioEngine::getInstance()->playEffect("gameover.mp3");
		/*初始化菜单层*/
		menuLayer = MenuLayer::create(Color4B(0, 0, 0, 100));
		this->addChild(menuLayer);
		auto menuSize = menuLayer->getContentSize();
		//添加标题
		auto menuTitle = LabelTTF::create("GAME OVER", "Arial", 30);
		menuTitle->setPosition(menuSize.width / 2, menuSize.height / 2 + 50);
		menuLayer->addChild(menuTitle);
		//添加当前分数
		auto menuscoreLabel = LabelTTF::create(String::createWithFormat("current: %d", score)->getCString(), "Arial", 20);
		menuscoreLabel->setPosition(menuSize.width / 2, menuSize.height / 2);
		menuLayer->addChild(menuscoreLabel);
		//添加最好分数
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