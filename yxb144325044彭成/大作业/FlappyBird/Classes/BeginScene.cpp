//
//  BeginScene.cpp
//  FlappyBird
//
//  Created by macc on 15/1/3.
//
//

#include "BeginScene.h"
#include "cocos2d.h"

cocos2d::CCScene* StartGame::scene()
{
    CCScene* scene=CCScene::create();
    StartGame* layer=StartGame::create();
    scene->addChild(layer);
    return scene;
}

bool StartGame::init()
{
    if (!CCLayer::init()) {
        return false;
    }
    
    CCSize size = CCDirector::sharedDirector()->getVisibleSize();
    
    //增加游戏名称
    CCLabelTTF* topic = CCLabelTTF::create("Flappy Bird", "Arial", 40);
    
    this->addChild(topic);
    
    //增加开始按钮
    CCMenuItemImage* startGame=CCMenuItemImage::create("btn-play-normal.png","btn-play-selected.png",this, menu_selector(StartGame::menuStart));
    
    CCMenuItemImage* highScore=CCMenuItemImage::create("btn-highscores-normal.png", "btn-highscores-selected.png", this, menu_selector(StartGame::menuHighScore));
    
    CCMenuItemImage* about= CCMenuItemImage::create("btn-about-normal.png", "btn-about-selected.png", this, menu_selector(StartGame::menuAbout));
    
    //设定所有元素的位置
    topic->setPosition(ccp(size.width/2,size.height/2+startGame->getContentSize().height*3));
    startGame->setPosition(ccp(size.width/2, size.height/2+startGame->getContentSize().height*1.5));
    highScore->setPosition(ccp(size.width/2,size.height/2));
    about->setPosition(ccp(size.width/2, size.height/2-startGame->getContentSize().height*1.5));
    
    
    CCMenu* menu = CCMenu::create(startGame,highScore,about,NULL);
    menu->setPosition(CCDirector::sharedDirector()->getVisibleOrigin());
    this->addChild(menu);
    
    CocosDenshion::SimpleAudioEngine::sharedEngine()->playBackgroundMusic("background-music-aac.wav", true);
    return true;
    
}

void StartGame::menuStart()
{
    //CocosDenshion::SimpleAudioEngine::sharedEngine()->stopBackgroundMusic();
    CCDirector::sharedDirector()->replaceScene(HelloWorld::scene());
}

void StartGame::menuHighScore()
{
    CCMessageBox("HighScore", "");
}

void StartGame::menuAbout()
{
    CCMessageBox("作者：彭成 2014.12.31","About");
}

