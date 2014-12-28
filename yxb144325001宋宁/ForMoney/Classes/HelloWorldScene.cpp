#include "HelloWorldScene.h"

USING_NS_CC;

#define RED_BIT_MASK    0b0100
#define GREEN_BIT_MASK  0b0010
#define BULE_BIT_MASK   0b0001
#define EDGE_BIT_MASK   0b1000

Scene* HelloWorld::createScene()
{
    // 'scene' is an autorelease object
    auto scene = Scene::createWithPhysics();
//    scene->getPhysicsWorld()->setDebugDrawMask(PhysicsWorld::DEBUGDRAW_ALL);
    scene->getPhysicsWorld()->setGravity(Vec2(0, -1000));
    
    // 'layer' is an autorelease object
    auto layer = HelloWorld::create();

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
    if ( !Layer::init() )
    {
        return false;
    }
    
    visibleSize = Director::getInstance()->getVisibleSize();
    origin = Director::getInstance()->getVisibleOrigin();
    
    schedule(schedule_selector(HelloWorld::addCoins), 1);
    
    
    return true;
}

void HelloWorld::addCoins(float dt){
//    float locationX=(random(0,15)/16.0)*(visibleSize.width-120)+60;
//    float locationY=(random(0,15)/16.0)*(visibleSize.height-120)+60;
//    log("%f----------%f",locationX,locationY);
//    if (i%5==0) {
//        Sprite* sp=createSpriteByTag(1, locationX, locationY);
//        this->addChild(sp);
//    }
//    for (auto sp_obj:sp_vec) {
////        if (sp_obj->g) {
////            statements
////        }
//        sp_obj->removeFromParentAndCleanup(true);
//    }
    i++;
}

void HelloWorld::onEnter(){
    Layer::onEnter();
    
    auto bounds=Node::create();
    bounds->setContentSize(visibleSize);
    bounds->setPhysicsBody(PhysicsBody::createEdgeBox(bounds->getContentSize()));
    bounds->setPosition(visibleSize.width/2,visibleSize.height/2);
    addChild(bounds);
    
    addEdges();
    
    Sprite* sp= createSpriteByTag(0, visibleSize.width/2, visibleSize.height/2);
    if (sp) {
        this->addChild(sp);
    }
    
    Device::setAccelerometerEnabled(true);
    
    Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(EventListenerAcceleration::create([this](Acceleration *a,Event *e){
        float gravityX=this->getScene()->getPhysicsWorld()->getGravity().x;
        float gravityY=this->getScene()->getPhysicsWorld()->getGravity().y;
        double locationX=(a->x<0.3&&a->x>-0.3) ? a->x:gravityX/2000;
        double locationY=(a->y<0.3&&a->y>-0.3) ? a->y:gravityY/2000;
        this->getScene()->getPhysicsWorld()->setGravity(Vec2(locationX*2000, locationY*2000));
    }), this);
    
    
    auto contactListener=EventListenerPhysicsContact::create();
    contactListener->onContactBegin = [this] (PhysicsContact & contact){
        
        return true;
    };
    contactListener->onContactPostSolve=[this](PhysicsContact& contact,const PhysicsContactPostSolve& solve){
        auto spriteA=(Sprite*)contact.getShapeA()->getBody()->getNode();
        auto spriteB=(Sprite*)contact.getShapeB()->getBody()->getNode();
        if (spriteA&&spriteB) {
            log("A----%d;B-------%d;I------%d",spriteA->getTag(),spriteB->getTag(),this->i);
            if (spriteA->getTag()==spriteB->getTag()) {
                int futureTag=spriteA->getTag()+spriteB->getTag();
                float locationX=(spriteA->getPosition().x+spriteB->getPosition().x)/2;
                float locationY=(spriteA->getPosition().y+spriteB->getPosition().y)/2;
                Sprite* sp=this->createSpriteByTag(futureTag, locationX, locationY);
                if (sp) {
                    this->addChild(sp);
                    spriteA->removeFromPhysicsWorld();
                    spriteA->removeFromParentAndCleanup(true);
                    spriteB->removeFromPhysicsWorld();
                    spriteB->removeFromParentAndCleanup(true);
                }
                
            }
        }
    };
    
    Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(contactListener, this);
    
    auto cache=SpriteFrameCache::getInstance();
    cache->addSpriteFramesWithFile("CoinsFalls.plist");
    
    auto touchListener=EventListenerTouchOneByOne::create();
    touchListener->onTouchBegan=[this](Touch *t,Event *e){
        float locationX=t->getLocation().x;
        float locationY=t->getLocation().y;
        log("%f----------%f",locationX,locationY);
        auto sprite=Sprite::create("5jiao500.png");
        sprite->setPosition(locationX,locationY);
        sprite->runAction(Sequence::create(
                                           ScaleTo::create(0.2, 0.96),
                                           ScaleTo::create(0.2, 0.86),
                                           ScaleTo::create(0.2, 0.68),
                                           ScaleTo::create(0.2, 0.43),
                                           ScaleTo::create(0.2, 0.12),
                                           CallFunc::create([sprite,locationX,locationY,this](){
                                                auto sp=this->createSpriteByTag(1, locationX, locationY);
                                                if (sp) {
                                                            this->addChild(sp);
                                                }
                                                sprite->removeFromParentAndCleanup(true);
            
                                            }),
                                           NULL
        ));
        sprite->setTag(-1);
        this->addChild(sprite);
//        this->sp_vec.pushBack(sprite);
        
        return false;
    };
    Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(touchListener, this);
    
    
}

void HelloWorld::addEdges(){
//    auto body=PhysicsBody::createEdgeBox(visibleSize,PHYSICSBODY_MATERIAL_DEFAULT,3);
    Size edgeBox=Size(visibleSize.width-80, visibleSize.height-80);
    auto body=PhysicsBody::createEdgeBox(edgeBox,PHYSICSBODY_MATERIAL_DEFAULT,3);
    auto edgeShape=Node::create();
    edgeShape->setPhysicsBody(body);
    edgeShape->setPosition(visibleSize.width/2,visibleSize.height/2);
    edgeShape->getPhysicsBody()->setContactTestBitmask(EDGE_BIT_MASK);
    addChild(edgeShape);
}

Sprite* HelloWorld::createSpriteByTag(int tag,float x,float y){
    std::string source="";
    switch (tag) {
        case 1:
            source="5jiao.png";
            break;
        case 2:
            source="1dao.png";
            break;
        case 4:
            source="1ou.png";
            break;
        case 8:
            source="GerOu.png";
            break;
        case 16:
            source="10ou.png";
            break;
        default:
            break;
    }
    if (source!="") {
        Sprite* sp=Sprite::create(source);
        sp->setPosition(Vec2(x, y));
        sp->setTag(tag);
        sp->setPhysicsBody(PhysicsBody::createCircle(sp->getContentSize().width/2));
        sp->getPhysicsBody()->setContactTestBitmask(RED_BIT_MASK);
        return sp;
    }else{
        return NULL;
    }
}