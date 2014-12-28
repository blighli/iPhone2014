//
//  StartScene.cpp
//  ForMoney
//
//  Created by NimbleSong on 14/12/27.
//
//

#include "StartScene.h"
#include "HelloWorldScene.h"


Scene* StartScene::createScene(){
    Scene* scene=Scene::create();
    StartScene * layer=StartScene::create();
    scene->addChild(layer);
    return scene;
}

bool StartScene::init(){
    
    if (!Layer::init()) {
        return false;
    }
    
    Size visibleSize=Director::getInstance()->getVisibleSize();
    
    LabelTTF *labelTitle=LabelTTF::create("硬币大作战", "Marker Felt", 80);
    
    addChild(labelTitle);
    labelTitle->setPosition(visibleSize.width/2,visibleSize.height/2+200);
    
    LabelTTF *Startlabel=LabelTTF::create("开始", "Marker Felt", 60);
    
    addChild(Startlabel); 
    Startlabel->setPosition(visibleSize.width/2,visibleSize.height/2);
    
    auto TouchListener=EventListenerTouchOneByOne::create();
    
    TouchListener->onTouchBegan =[Startlabel](Touch* t,Event* e){
        if (Startlabel->getBoundingBox().containsPoint(t->getLocation())) {
            auto scene = HelloWorld::createScene();
            Director::getInstance()->replaceScene(scene);
        }
        return false;
    };
    
    Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(TouchListener, this);
    
    return true;
}