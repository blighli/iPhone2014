#include "HelloWorldScene.h"
#include "GameOver.h"
#include "SimpleAudioEngine.h"

USING_NS_CC;

CCScene* HelloWorld::scene()
{
    // 'scene' is an autorelease object
    CCScene *scene = CCScene::create();
    
    // 'layer' is an autorelease object
    HelloWorld *layer = HelloWorld::create();
    
    // add layer as a child to scene
    scene->addChild(layer);
    
    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !CCLayer::init() )
    {
        return false;
    }
    
    visibleSize = CCDirector::sharedDirector()->getVisibleSize();
    origin = CCDirector::sharedDirector()->getVisibleOrigin();
    
    score = 0;
    
    initWorld();
    addBird();
    addGround();
    scheduleUpdate();
    
    
    showScore = CCLabelTTF::create("SCORE:0", "Arial", 20);
    showScore->setPosition(ccp(100,visibleSize.height-10));
    this->addChild(showScore,1);
    
    //每隔一秒调用一次回调函数addBar(float dt)
    schedule(schedule_selector(HelloWorld::addBar), 1.3f);
    
    //设定可以点击
    setTouchEnabled(true);
    
    //添加背景音乐
    CocosDenshion::SimpleAudioEngine::sharedEngine()->playBackgroundMusic("background.mp3", true);
    
    return true;
}

void HelloWorld::addBar(float dt)
{
    //设定随机数调整bar
    float offset = -rand()%5;
    
    //downbar
    
    B2Sprite * down_bar = B2Sprite::create("down_bar.png");
    CCSize down_bar_size = down_bar->getContentSize();
    
    b2BodyDef down_bar_body_def;
    //非静态也非动态
    down_bar_body_def.type = b2_kinematicBody;
    down_bar_body_def.position = b2Vec2(visibleSize.width/RATIO+2, down_bar_size.height/RATIO/2+offset);
    //设定bar从右往左移动
    down_bar_body_def.linearVelocity = b2Vec2(-3.5, 0);
    b2Body * down_bar_body = world->CreateBody(&down_bar_body_def);
    
    b2PolygonShape down_bar_shape;
    down_bar_shape.SetAsBox(down_bar_size.width/2/RATIO, down_bar_size.height/2/RATIO);
    b2FixtureDef down_bar_fixture_def;
    down_bar_fixture_def.shape = &down_bar_shape;
    down_bar_body->CreateFixture(&down_bar_fixture_def);
    
    down_bar->setB2Body(down_bar_body);
    down_bar->setPTMRatio(RATIO);
    addChild(down_bar);
    
    //upbar
    
    up_bar = B2Sprite::create("up_bar.png");
    up_bar->setTag(101);
    CCSize up_bar_size = up_bar->getContentSize();
    
    b2BodyDef up_bar_body_def;
    //非静态也非动态
    up_bar_body_def.type = b2_kinematicBody;
    up_bar_body_def.position = b2Vec2(visibleSize.width/RATIO+2, down_bar_size.height/RATIO+offset+2+up_bar_size.height/2/RATIO);
    //设定bar从右往左移动
    up_bar_body_def.linearVelocity = b2Vec2(-3.5, 0);
    b2Body * up_bar_body = world->CreateBody(&up_bar_body_def);
    
    b2PolygonShape up_bar_shape;
    up_bar_shape.SetAsBox(up_bar_size.width/2/RATIO, up_bar_size.height/2/RATIO);
    b2FixtureDef up_bar_fixture_def;
    up_bar_fixture_def.shape = &up_bar_shape;
    up_bar_body->CreateFixture(&up_bar_fixture_def);
    
    up_bar->setB2Body(up_bar_body);
    up_bar->setPTMRatio(RATIO);
    addChild(up_bar);
}

void HelloWorld::addGround()
{
    //创建地面1
    B2Sprite *ground = B2Sprite::create("ground.png");
    //获得地面的size
    CCSize size = ground->getContentSize();
    
    b2BodyDef bDef;
    bDef.type = b2_staticBody;//设置为静态
    //地面放置的位置
    bDef.position = b2Vec2(size.width/2/RATIO, size.height/2/RATIO);
    b2Body * groundBody = world->CreateBody(&bDef);
    
    b2PolygonShape groundShape;
    groundShape.SetAsBox(size.width/2/RATIO, size.height/2/RATIO);
    b2FixtureDef groundFixtureDef;
    groundFixtureDef.shape =&groundShape;
    groundBody->CreateFixture(&groundFixtureDef);
    
    ground->setB2Body(groundBody);
    ground->setPTMRatio(RATIO);
    addChild(ground,1);
    
    
    //创建地面2
    B2Sprite *ground2 = B2Sprite::create("ground.png");
    //获得地面的size
    CCSize size2 = ground2->getContentSize();
    
    b2BodyDef bDef2;
    bDef2.type = b2_staticBody;//设置为静态
    //地面放置的位置
    bDef2.position = b2Vec2((size2.width+640)/2/RATIO, size2.height/2/RATIO);
    b2Body * groundBody2 = world->CreateBody(&bDef2);
    
    b2PolygonShape groundShape2;
    groundShape2.SetAsBox(size2.width/2/RATIO, size2.height/2/RATIO);
    b2FixtureDef groundFixtureDef2;
    groundFixtureDef2.shape =&groundShape2;
    groundBody2->CreateFixture(&groundFixtureDef2);
    
    ground2->setB2Body(groundBody2);
    ground2->setPTMRatio(RATIO);
    addChild(ground2,1);
}

//初始化物理世界
void HelloWorld::initWorld()
{
    world = new b2World(b2Vec2(0,-10));//x轴方向无重力，y方向为10
    world->SetContactListener(this);
}

void HelloWorld::BeginContact(b2Contact *contact)
{
    if (contact->GetFixtureA()->GetBody()->GetUserData()==bird||
        contact->GetFixtureB()->GetBody()->GetUserData()==bird) {
        //结束游戏切换到结束场景
        unscheduleUpdate();
        unschedule(schedule_selector(HelloWorld::addBar));
        
        //通过tag找到对应的layer
        CCScene* overScene=GameOver::scene();
        GameOver* overLayer = (GameOver*)overScene->getChildByTag(100);
        
        char str[40];
        sprintf(str, "您的分数是：%d",score);
        overLayer->_label->setString(str);
        CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect("hit.mp3");
        //停止背景音乐
        CocosDenshion::SimpleAudioEngine::sharedEngine()->stopBackgroundMusic();
        CCDirector::sharedDirector()->replaceScene(overScene);
        //这里试验多次无法切换场景，发现是游戏结束类的init()方法最后返回了false，坑啊
        //CCMessageBox("失败", "游戏失败");
    }
}

void HelloWorld::addBird()
{
    bird = B2Sprite::create("bird.png");
    CCSize size = bird->getContentSize();
    
    
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position = b2Vec2(visibleSize.width/2/RATIO, 9);
    b2Body * birdBody = world->CreateBody(&bodyDef);
    
    b2PolygonShape birdShape;
    birdShape.SetAsBox(size.width/2/RATIO, size.height/2/RATIO);
    
    b2FixtureDef birdFixtureDef;
    birdFixtureDef.shape = &birdShape;
    //为小鸟加上碰撞检测的形状（方形）
    birdBody->CreateFixture(&birdFixtureDef);
    
    //设置box2d与cocos世界的比例
    bird->setPTMRatio(RATIO);
    bird->setB2Body(birdBody);
    addChild(bird);
}

void HelloWorld::update(float dt)
{
    world->Step(dt, 8, 3);
    CCSprite *s;
    
    for (b2Body * b = world->GetBodyList();b!=NULL;b=b->GetNext())
    {
        s = (CCSprite*)b->GetUserData();
        ///////////////////问题／／／／／
        
        if (s->getTag()==101&&b->GetPosition().x<6) {
            score++;
            CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect("pickup.mp3");
            
            //修改显示的分数
            char str[40];
            sprintf(str, "SCORE:%d",score);
            showScore->setString(str);
            
            //修改标签数字，防止重复计数
            s->setTag(10);
        }
        
        //这里的if顺序是固定的，否则
        if (b->GetPosition().x<-5) {
            
            if (s!=NULL){
                s->removeFromParent();
            }
            world->DestroyBody(b);
            
        }
    }
}

//设定点击响应函数
void HelloWorld::ccTouchesBegan(cocos2d::CCSet *pTouches, cocos2d::CCEvent *pEvent)
{
    //为小鸟增加一个向上运动的速度
    //cout<<"x----->"<<bird->getRotationX()<<endl;
    //bird->setRotationY(30.0f);
    //scheduleOnce(schedule_selector(HelloWorld::changeRotation), 1);
    bird->getB2Body()->SetLinearVelocity(b2Vec2(0, 4.7));
}




void HelloWorld::menuCloseCallback(CCObject* pSender)
{
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WINRT) || (CC_TARGET_PLATFORM == CC_PLATFORM_WP8)
    CCMessageBox("You pressed the close button. Windows Store Apps do not implement a close button.","Alert");
#else
    CCDirector::sharedDirector()->end();
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
#endif
}
