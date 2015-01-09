#ifndef __HELLOWORLD_SCENE_H__
#define __HELLOWORLD_SCENE_H__

#include "cocos2d.h"
#include "Box2D.h"
#include "B2Sprite.h"
#include "SimpleAudioEngine.h"

#define RATIO 48.0f

class HelloWorld : public cocos2d::CCLayer,public b2ContactListener
{
public:
    // Here's a difference. Method 'init' in cocos2d-x returns bool, instead of returning 'id' in cocos2d-iphone
    virtual bool init();  

    // there's no 'id' in cpp, so we recommend returning the class instance pointer
    static cocos2d::CCScene* scene();
    
    // a selector callback
    void menuCloseCallback(CCObject* pSender);
    
    // implement the "static node()" method manually
    CREATE_FUNC(HelloWorld);
    
    virtual void update(float dt);
    virtual void ccTouchesBegan(CCSet *pTouches, CCEvent *pEvent);
    virtual void BeginContact(b2Contact *contact);
    
    //声明物理世界
    b2World *world;
    //声明物理世界中的小鸟
    B2Sprite *bird;
    B2Sprite * up_bar;
    
    CCSize visibleSize;
    CCPoint origin;
    
    CCLabelTTF* showScore;
    int score;
private:
    void addBird();
    void initWorld();
    void addGround();
    void addBar(float dt);
    void startGame();
    void stopGame();
    //void changeRotation();
};

#endif // __HELLOWORLD_SCENE_H__
