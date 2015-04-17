//
//  GameOver.cpp
//  FlappyBird
//
//  Created by macc on 15/1/3.
//
//

#include "GameOver.h"
#include "cocos2d.h"

USING_NS_CC;


bool GameOver::init()
{
    if(CCLayerColor::initWithColor(ccc4(0,0,0,0)))
    {
        _label = CCLabelTTF::create("word", "Arial", 40);
        CCSize size = CCDirector::sharedDirector()->getVisibleSize();
        _label ->setPosition(ccp(size.width/2, size.height/2));
        this ->addChild(_label);
        
        _label ->retain();
    }
    
    
    CCSize size = CCDirector::sharedDirector()->getVisibleSize();
    //返回按钮使用了cocos自带的关机图片
    CCMenuItemImage* back = CCMenuItemImage::create("CloseNormal.png", "CloseSelected.png", this, menu_selector(GameOver::menuBack));
    
    back->setPosition(ccp(size.width/2, size.height/2-100));
    
    CCMenu* menu = CCMenu::create(back,NULL);
    menu->setPosition(CCDirector::sharedDirector()->getVisibleOrigin());
    this->addChild(menu);
    
    return true;
}

void GameOver::menuBack()
{
    CCDirector::sharedDirector()->replaceScene(StartGame::scene());
}

GameOver::~GameOver()
{
    if(_label)
    {
        _label->release();
    }
}

cocos2d::CCScene* GameOver::scene()
{
    CCScene * scene = CCScene::create();
    GameOver* layer = GameOver::create();
    
    layer->setTag(100);
    
    scene ->addChild(layer);
    return scene;
}
