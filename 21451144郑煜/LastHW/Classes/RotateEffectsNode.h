//
//  RotateEffectsNode.h
//  BlockJourney
//
//  Created by StarJade on 14-12-19.
//
//

#ifndef __BlockJourney__RotateEffectsNode__
#define __BlockJourney__RotateEffectsNode__

#include "heads.h"

class RotateEffectsNode: public cocos2d::Node {
	
	cocos2d::Sprite * comet[4];
	cocos2d::Vec2 initPos[4];
	cocos2d::Vec2 destPos[4];
	
	cocos2d::Vec2 vec[4];
	cocos2d::Vec2 antiVec[4];
	
	Fun00 cb;//回调函数
public:
	bool init(Fun00 cb);
	static RotateEffectsNode *create(Fun00 cb);
	
	//
	void runRotateEffects(bool isCW);
	
private:
	void setRotation(int i);
};

#endif /* defined(__BlockJourney__RotateEffectsNode__) */
