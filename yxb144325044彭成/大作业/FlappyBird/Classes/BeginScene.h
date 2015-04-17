//
//  BeginScene.h
//  FlappyBird
//
//  Created by macc on 15/1/3.
//
//

#ifndef __FlappyBird__BeginScene__
#define __FlappyBird__BeginScene__

#include "cocos2d.h"
#include "HelloWorldScene.h"
#include "SimpleAudioEngine.h"

class StartGame: public cocos2d::CCLayer
{
public:
    bool init();
    CREATE_FUNC(StartGame);
    
    static cocos2d::CCScene* scene();
    
    void menuStart();
    void menuHighScore();
    void menuAbout();
};



#endif /* defined(__FlappyBird__BeginScene__) */
