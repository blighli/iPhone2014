//
//  homeSceneData.h
//  BlockJourney
//
//  Created by StarJade on 14-12-10.
//
//

#ifndef BlockJourney_homeSceneData_h
#define BlockJourney_homeSceneData_h

namespace HomeSceneData {
//	H位置：
//	
//	标题：78%
	
	const float TITLE_H_PERCENT = 0.78f;
//	开始按键：34.6%
	
	const float START_H_PERCENT = 0.346f;
//	其他按键：7.8%
	const float BUTTON_H_PERCENT = 0.068f;
//
//	contentSize：(640,327)
	const cocos2d::Size HUD_CONTENT_SIZE = cocos2d::Size(640,327);
//	领悟等级：(64,230)左对齐
	const cocos2d::Vec2 COMPREHEND_POS = cocos2d::Vec2(64,237);
	//	最长历世：(74,50)左对齐
	const cocos2d::Vec2 MAX_LIFE_ROUND_POS = cocos2d::Vec2(74,50);
	
	// 箭头按键(564,39)
	const cocos2d::Vec2 ARROW_BUTTON_POS = cocos2d::Vec2(564,39);
}

#endif
