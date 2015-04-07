//
//  LifeCircle.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-6.
//
//

#include "public.h"

bool LifeCircle::init(){
	if (!RectDrawNode::init()) {
		return false;
	}
	
	//
	touchEnable = true;
	
	
	this->resetLifeCircle();
	
	//添加飞溅精灵
	for (int i = 0; i < LENGTH; ++i) {
		for (int j = 0; j < LENGTH; ++j) {
			splashes[i*LENGTH + j] = Sprite::create("splash.png");
			splashes[i*LENGTH + j]->setPosition(this->blockPos[i][j]);
			splashes[i*LENGTH + j]->setOpacity(0);
//			splashes[i*LENGTH + j]->setScale(0.1f);
			this->addChild(splashes[i*LENGTH + j]);
			
		}
	}
	
	// 添加旋转精灵
	this->initRotateSprites();
	
	
	return true;
}

void LifeCircle::resetLifeCircle(){
	ShapeModel::sharedModel()->resetSpinShapesAndMoveShape();
	this->redraw();
}

void LifeCircle::rotate(){
	
	if (!touchEnable) return;
	
	this->runRotateEffects(true);
	ShapeModel::sharedModel()->rotate();
//	this->redraw();
}

void LifeCircle::antiRotate(){
	
	if (!touchEnable) return;
	
	this->runRotateEffects(false);
	ShapeModel::sharedModel()->antiRotate();
//	this->redraw();
}

void LifeCircle::fillLifeCircle(){
	auto shape = ShapeModel::sharedModel()->getFullShape();
	this->RedrawRect(shape);
}

void LifeCircle::runCollisionEffects(CallFunc *callback){
	
	// 特效动作
	
	ShapeModel::Shape shape = ShapeModel::sharedModel()->getOverlapShape();
	for (int i = 0; i < LENGTH; ++i) {
		for (int j = 0; j < LENGTH; ++j) {
			if (shape.shape[i][j]==1) {
				
				printf("runCollisionEffects this block in collision!!");
				//
				splashes[i*LENGTH + j]->setOpacity(255);
				splashes[i*LENGTH + j]->setScale(0.2f);
				splashes[i*LENGTH + j]->setRotation( arc4random()%360);
				
				auto zoomIn = ScaleTo::create(0.8f, 0.6);
				auto fadeOut = FadeOut::create(1.0f);
				
				auto spawn = Spawn::create(zoomIn, NULL);
				auto seq = Sequence::create(spawn,fadeOut, callback, NULL);
				//
				splashes[i*LENGTH + j]->runAction(seq);
				
			}
			
			
		}
	}
	
}
///////////////////////////////////////////////////////
void LifeCircle::redraw(){
	
	auto shape = ShapeModel::sharedModel()->getSpinShape();
	this->RedrawRect(shape);
}

void LifeCircle::initRotateSprites(){
	
	rotateEffectsNode = RotateEffectsNode::create(CC_CALLBACK_0(LifeCircle::rotateEffectsEnd, this));
	rotateEffectsNode->setPosition(this->getContentSize().width/2,this->getContentSize().height/2);
	
	this->addChild(rotateEffectsNode);
}

void LifeCircle::runRotateEffects(bool isCW){
	
	// 状态转变为不可旋转
	touchEnable = false;
	
	// 执行旋转效果
	rotateEffectsNode->runRotateEffects(isCW);
	
}

void LifeCircle::rotateEffectsEnd(){
	// 状态转变为可旋转
	touchEnable = true;
	
	//
	this->redraw();
}