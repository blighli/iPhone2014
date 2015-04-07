//
//  MenuLayer.h
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//

#ifndef __BlockJourney__MenuLayer__
#define __BlockJourney__MenuLayer__

#include "heads.h"

class MenuLayer: public cocos2d::Layer {
private:
	cocos2d::Menu *menu;
	
public:
	bool init();
	CREATE_FUNC(MenuLayer);
	
public:
	void onBackToHome(cocos2d::Ref* pSender);
	void setEnable(bool enable);
	
};

#endif /* defined(__BlockJourney__MenuLayer__) */
