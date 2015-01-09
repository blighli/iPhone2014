//
//  GameOver.h
//  FlappyBird
//
//  Created by macc on 15/1/3.
//
//

#ifndef __FlappyBird__GameOver__
#define __FlappyBird__GameOver__

#include "cocos2d.h"
#include "BeginScene.h"

class GameOver : public cocos2d::CCLayerColor
{
public:
    bool init();
    CREATE_FUNC(GameOver);//如果定义成功就会调用init方法
    static cocos2d::CCScene* scene();//每一个场景都要创建scene,场景切换只能在scene之间切换
    
    cocos2d::CCLabelTTF* _label;
    
    ~GameOver();
    void menuBack();
};

#endif /* defined(__FlappyBird__GameOver__) */
