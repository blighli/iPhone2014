//
//  gameSceneData.h
//  BlockJourney
//
//  Created by StarJade on 14-12-8.
//
//

#ifndef BlockJourney_gameSceneData_h
#define BlockJourney_gameSceneData_h

#include "cocos2d.h"


namespace GameSceneData {
	
#define SCREEN_HEIGHT 960
	
	//准备层：
	
	//左箭头：
	const cocos2d::Vec2 LEFT_ARROW_POS = cocos2d::Vec2(111,SCREEN_HEIGHT - 901);
	
	//右箭头：
	
	const cocos2d::Vec2 RIGHT_ARROW_POS = cocos2d::Vec2(531,SCREEN_HEIGHT - 901);
	
	
	//游戏层：
	//轮回框起始位置：(320,0)
	const cocos2d::Vec2 ROUND_CIRCLE_POS = cocos2d::Vec2(320,SCREEN_HEIGHT - 0);
	
	// 起始位置所处百分比
	const float ROUND_CIRCLE_H_PERCENT = 1.0f;
	
	//生命框位置：(320,689)
	const cocos2d::Vec2 LIFE_CIRCLE_POS = cocos2d::Vec2(320,SCREEN_HEIGHT - 689);
	
	const float LIFE_CIRCLE_H_PERCENT = 0.21f;
	
	// 生命框放缩比例
	//最大屏幕长宽比/当前屏幕长宽比
	
	//框颜色：(197,158,171) // TODO 注意下面这个变量由于包含了透明度，所以没有包括所有绘制情况。
	const cocos2d::Color4B CIRCLE_COLOR = cocos2d::Color4B(197,158,171,200);
	const cocos2d::Color4B ROUND_CIRCLE_COLOR = cocos2d::Color4B(197,158,209,200);
	const cocos2d::Color4B LIFE_CIRCLE_COLOR = CIRCLE_COLOR;
	
	
	//菜单层：
	//Home：(71,199) 61%
	const cocos2d::Vec2 HOME_BTN_POS = cocos2d::Vec2(72,807);
	const float HOME_H_PERCENT = 0.82f;
	
	//	HUD容器大小：(639,82)
	//HUD层：
	//HUD容器大小：(639,82)
	const cocos2d::Size HUD_Content_Size = cocos2d::Size(639,82);
	
	//HUD文字：(332,41)
	const cocos2d::Vec2 HUD_TEXT_POS = cocos2d::Vec2(320,41);
	
	//	残念：(116,19)//右中为锚点，右对齐
	const cocos2d::Vec2 HUD_REMNANTS_POS = cocos2d::Vec2(116,19);
	//	领悟等级：(530,69)//左上为锚点，左对齐
	const cocos2d::Vec2 HUD_COMPREHEND_POS = cocos2d::Vec2(527,63);//(530,100);
	
	//指针起点：(138,33)
	const cocos2d::Vec2 HUD_POINT_START_POS = cocos2d::Vec2(139,48);
	
	//指针终点：(417,33)
	const cocos2d::Vec2 HUD_POINT_END_POS = cocos2d::Vec2(418,48);
	
	//圆盘位置：(417,48)
	const cocos2d::Vec2 HUD_TARGET_POS = cocos2d::Vec2(418,33);
	//进度条位置；(139,46)左对齐 //(273,46) 居中
	const cocos2d::Vec2 HUD_PROCESS_POS = cocos2d::Vec2(139,35);
	
}

#endif
