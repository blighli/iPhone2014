//
//  HUDLayer.h
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//

#ifndef __BlockJourney__HUDLayer__
#define __BlockJourney__HUDLayer__

#include "heads.h"

class HUDLayer:public cocos2d::Layer {
	
	cocos2d::Label *remnantsLabel;
	cocos2d::Label * comprehendLabel;
	
	
	cocos2d::Sprite * pointer;//进度指针
	cocos2d::Sprite * process;
	
public:
	bool init();
	CREATE_FUNC(HUDLayer);
	
public:
	void update(float dt);

};

#endif /* defined(__BlockJourney__HUDLayer__) */
