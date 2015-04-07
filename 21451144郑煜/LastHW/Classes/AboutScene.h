//
//  AboutScene.h
//  BlockJourney
//
//  Created by StarJade on 14-12-19.
//
//

#ifndef __BlockJourney__AboutScene__
#define __BlockJourney__AboutScene__

#include "heads.h"

class AboutScene: cocos2d::Layer {
	
	
public:// 初始化
	bool init();
	CREATE_FUNC(AboutScene);
	static cocos2d::Scene *scene();
	
public:// 跳转
	void onToHome(cocos2d::Ref *pSender);
	
};

#endif /* defined(__BlockJourney__AboutScene__) */
