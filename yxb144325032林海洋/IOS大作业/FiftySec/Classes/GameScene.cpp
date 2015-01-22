#include "GameScene.h"

GameScene* GameScene::create(const Color4B& color,PhysicsWorld *_world)
{
		GameScene *pRet = new GameScene();
		pRet->world = _world;
		if (pRet && pRet->initWithColor(color))
		{
			pRet->setName("GameScene");		
			pRet->autorelease();
			return pRet;
		}
		else
		{
			delete pRet;
			pRet = NULL;
			return NULL;
		}
}

Scene* GameScene::createScene(const Color4B& color)
{
	auto scene = Scene::createWithPhysics();
	//scene->getPhysicsWorld()->setDebugDrawMask(PhysicsWorld::DEBUGDRAW_ALL);
	scene->getPhysicsWorld()->setGravity(Vec2(0,0));
	scene->getPhysicsWorld()->setSpeed(level0Speed);
	//scene->getPhysicsBody()->setRotationEnable(false);
	auto lay = GameScene::create(color,scene->getPhysicsWorld());
	log("lay done  29");
	scene->addChild(lay,0);//lay - 0
	return scene;
}

bool GameScene::initWithColor(const Color4B& color)
{
	LayerColor::initWithColor(color);
	visibleSize = Director::getInstance()->getVisibleSize();
	origin = Director::getInstance()->getVisibleOrigin();
	addbackground();
	paramInit();//init the param
	addGradelabel();
	addEdges();
	addControlBlock();
	addblocks();

	scheduleUpdate();
	return true;
}

int GameScene::getcurtime()
{
#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
	struct  timeval now;
	struct tm * time;

	gettimeofday(&now, NULL);

	time = localtime(&now.tv_sec);

	int sec = time->tm_sec;
	int min = time->tm_min;
	//log("min = %d,sec = %d",min,sec);

	return (min*60 + sec);
#endif

#if(CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 || CC_TARGET_PLATFORM == CC_PLATFORM_WP8) 
	struct tm *tm;
	time_t timep;
	time(&timep);

	tm = localtime(&timep);

	int sec = tm->tm_sec;
	int min = tm->tm_min;
	//log("min = %d ,sec = %d", min , sec);
	return (min * 60 + sec);
#endif
}

void GameScene::update(float dt)
{
	auto bdx = rocker->getBoundingBox();
	for (int i = 0; i < 4;i++)
	{
		auto bbdx = block[i]->getBoundingBox();
		if (bbdx.containsPoint(Vec2(bdx.getMinX(), bdx.getMinY())) || bbdx.containsPoint(Vec2(bdx.getMinX(), bdx.getMaxY()))||bbdx.containsPoint(Vec2(bdx.getMaxX(),bdx.getMinY()))||bbdx.containsPoint(Vec2(bdx.getMaxX(),bdx.getMaxY())))
		{
			isGameStart = false;
			Director::getInstance()->replaceScene(End::createScene(grade));
		}
	}
	if (isGameStart)
	{
		grade = getcurtime() - sec_start;
		if (grade >= 10)
		{
			world->setSpeed(level1Speed);
		}
		else if (grade >= 20)
		{
			world->setSpeed(level2Speed);
		}
		else if (grade >= 30)
		{
			world->setSpeed(level3Speed);
		}
		else if (grade >= 40)
		{
			world->setSpeed(level4Speed);
		}
		else if (grade >= 50)
		{
			world->setSpeed(level5Speed);
		}
		else if (grade >=70)
			world->setSpeed(GodSpeed);
			
		label_grade->setString(StringUtils::format("%d", grade));
	}
			
}

void GameScene::paramInit()
{	
	auto bac_pos = bac->getBoundingBox();
	count = 0;
	isGameStart = false;
	grade = 0;
	block_init_pos[0] = Vec2(bac_pos.getMinX()+offset, bac_pos.getMaxY()-offset);
	block_init_pos[1] = Vec2(bac_pos.getMaxX()-offset, bac_pos.getMaxY()-offset);
	block_init_pos[2] = Vec2(bac_pos.getMinX()+offset,bac_pos.getMinY()+offset);
	block_init_pos[3] = Vec2(bac_pos.getMaxX()-offset,bac_pos.getMinY()+offset);
	auto w = visibleSize.width;
	auto h = visibleSize.height;
	block_init_des[0] = Vect(w, -h);
	block_init_des[1] = Vect(-w,-h);
	block_init_des[2] = Vect(w,h);
	block_init_des[3] = Vect(-w,h);

}
void GameScene::addbackground()
{
	bac = Sprite::create(background);
	bac->setAnchorPoint(Vec2(0.5, 0.5));
	bac->setScaleX(visibleSize.width / bac->getContentSize().width);
	bac->setScaleY(visibleSize.height / bac->getContentSize().height);
	bac->setPosition(Vec2(visibleSize.width / 2,visibleSize.height / 2));
	this->addChild(bac, 1);
}

void GameScene::addGradelabel()
{
	label_grade = LabelTTF::create();
	label_grade->setFontName("verdana");
	label_grade->setFontSize(40);
	label_grade->setString("0");
	label_grade->setPosition(Vec2(visibleSize.width/2,visibleSize.height *3 / 4));
	label_grade->setScale(visibleSize.width / label_grade->getContentSize().width/30);
	this->addChild(label_grade,4);
}
void GameScene::addEdges()
{
	edge = PhysicsBody::createEdgeBox(Size(visibleSize.width, visibleSize.height), PhysicsMaterial(0.1f,1.0f,0.0f), 0.5f);
	auto node = Node::create();
	node->setPhysicsBody(edge);
	node->setPosition(Vec2(visibleSize.width/2,visibleSize.height/2));
	this->addChild(node);
}

void GameScene::addControlBlock()
{
	rocker = Sprite::create(squ);
	rocker->setPosition(Vec2(visibleSize.width/2,visibleSize.height/2));
	rocker->setScale(visibleSize.width / rocker->getContentSize().width / 13);
	this->addChild(rocker, 2);//control - 2

	auto listener = EventListenerTouchOneByOne::create();
	listener->onTouchBegan = [this](Touch*t, Event *e){
			if (rocker->getBoundingBox().containsPoint(t->getLocation()))
			{
				count++;
				if (count == 1)
				{//first touch
					sec_start = getcurtime();
					//log("%d  %d",count, sec_start);
				}
				isGameStart = true;
				for (int i = 0; i < 4;i++)
				{//block can move
					if (count == 1)
					block[i]->getPhysicsBody()->setVelocity(block_init_des[i]);
				}//start move
			}		
			return true;
	};
	listener->onTouchMoved = [this](Touch *t, Event *e){
		rocker->setPosition(t->getLocation());
			if (rocker->getBoundingBox().getMinX() <= bac->getBoundingBox().getMinX() || 
				rocker->getBoundingBox().getMaxX() >= bac->getBoundingBox().getMaxX() ||
				rocker->getBoundingBox().getMinY() <= bac->getBoundingBox().getMinY() ||
				rocker->getBoundingBox().getMaxY() >= bac->getBoundingBox().getMaxY())
			{
				isGameStart = false;
				Director::getInstance()->replaceScene(End::createScene(grade));
			}
	};
	Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(listener, rocker);
}

void GameScene::addblocks()
{
	int mess = 0x01;
	for (int i = 0; i < 4; i++)
	{
		if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32 || CC_TARGET_PLATFORM == CC_PLATFORM_WP8)
		{
			block[i] = Sprite::create(StringUtils::format("block\\block_%d.png", i + 1).c_str());
		}
		else if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
		{
			block[i] = Sprite::create(StringUtils::format("block/block_%d.png", i + 1).c_str());
		}
        else if(CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
        {
            block[i] = Sprite::create(StringUtils::format("block_%d.png", i + 1).c_str());
        }
		block[i]->setScale(visibleSize.width / block[i]->getContentSize().width / 13);
		block[i]->setPhysicsBody(PhysicsBody::createBox(block[i]->getContentSize(), PhysicsMaterial(0,1.0f,0.0f), Vec2(0.5f,0.5f)));
		this->addChild(block[i], 2);
		block[i]->getPhysicsBody()->setRotationEnable(false);
		block[i]->setPosition(block_init_pos[i]);
		block[i]->getPhysicsBody()->setCategoryBitmask(0x01);
		block[i]->getPhysicsBody()->setContactTestBitmask(mess);
		mess<<=1;
		block[i]->getPhysicsBody()->setCollisionBitmask(0x10);
	}
}
