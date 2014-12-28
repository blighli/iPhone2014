//
//  StartScene.h
//  ForMoney
//
//  Created by NimbleSong on 14/12/27.
//
//

#ifndef __ForMoney__StartScene__
#define __ForMoney__StartScene__

#include <stdio.h>
#include <cocos2d.h>

USING_NS_CC;

class StartScene:public Layer {
    
public:
    virtual bool init();
    
    
    static Scene* createScene();
    
    CREATE_FUNC(StartScene);
};

#endif /* defined(__ForMoney__StartScene__) */
