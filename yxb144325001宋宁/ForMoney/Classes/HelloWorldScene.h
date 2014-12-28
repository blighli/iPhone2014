#ifndef __HELLOWORLD_SCENE_H__
#define __HELLOWORLD_SCENE_H__

#include "cocos2d.h"

class HelloWorld : public cocos2d::Layer
{
private:
    cocos2d::Size visibleSize;
    cocos2d::Vec2 origin;
    cocos2d::Vector<cocos2d::Sprite *> sp_vec;
    int i;
public:
    // there's no 'id' in cpp, so we recommend returning the class instance pointer
    static cocos2d::Scene* createScene();
    
    // Here's a difference. Method 'init' in cocos2d-x returns bool, instead of returning 'id' in cocos2d-iphone
    virtual bool init();
    
    virtual void onEnter();
    void addEdges();
    
    void addCoins(float dt);
    
    cocos2d::Sprite* createSpriteByTag(int tag,float x,float y);
    // implement the "static create()" method manually
    CREATE_FUNC(HelloWorld);
};

#endif // __HELLOWORLD_SCENE_H__
