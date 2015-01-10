//
//  BackGroundLayer.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-7.
//
//

#include "public.h"

bool BackGroundLayer::init(){
	if (!LayerColor::initWithColor(Color4B(221,218,209,255))) {
		return false;
	}
	
	auto background = Sprite::create("background.png");
	background->setAnchorPoint(Vec2(0,0));
	this->addChild(background);
	
	return true;
}

