//
//  RectDrawNode.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-6.
//
//

#include "public.h"


bool RectDrawNode::init(){
	
	if ( !DrawNode::init() )
	{
		return false;
	}
	
	
	Size winSize = Director::getInstance()->getWinSize();
	
	float maxRate = (float)1153 / 640;
	
	float scale = (winSize.height/winSize.width)/maxRate;
	
	////// 初始化变量
	width = 500*scale;// 矩形圈的宽度
	height = 300*scale;// 矩形圈的长度
	
	delWidth = DEL_WIDTH*scale;
	
	//////
	
	// 设置每个小方块的位置  //注意次序不能跟上面部分打乱
	float dX = getDrawPosAt(1, 1, LENGTH * 2).x - getDrawPosAt(0,0, LENGTH).x;//3阶（0，0）方块的中点即6阶（1，1）方块的左上坐标
	float dY = getDrawPosAt(1, 1, LENGTH * 2).y - getDrawPosAt(0,0, LENGTH).y;
	
	for(int i = 0; i < LENGTH; ++i){
		for (int j = 0; j < LENGTH; ++j) {
			blockPos[i][j].x = getDrawPosAt(i, j).x + dX;
			blockPos[i][j].y = getDrawPosAt(i, j).y + dY;
			
		}
	}
	
	this->setContentSize(Size(Vec2(width,height)));
	this->setAnchorPoint(Vec2(0.5,0.5));
	
	
	return true;
}

void RectDrawNode::RedrawRect(ShapeModel::Shape shape){
	
	//	清空画布
	this->clear();
	
	//	绘制小方块
	for (int i = 0; i < LENGTH; ++i) {
		for (int j = 0; j < LENGTH; ++j) {
			if (shape.shape[i][j] == 1) {
				
				Vec2 point[4];
				point[0] = getDrawPosAt(i, j);
				point[1] = getDrawPosAt(i, j+1);
				point[2] = getDrawPosAt(i+1,j+1);
				point[3] = getDrawPosAt(i+1	,j);
				
				this->drawPolygon(point, 4, Color4F(GameSceneData::CIRCLE_COLOR), 3, Color4F(1,0,0,0));
			}
		}
	}
	
	//	绘制限定表现
	
	Vec2 point[4];
	point[0] = getDrawPosAt(0, 0);
	point[1] = getDrawPosAt(0, LENGTH);
	point[2] = getDrawPosAt(LENGTH, LENGTH);
	point[3] = getDrawPosAt(LENGTH, 0);
	
	this->drawPolygon(point, 4, Color4F(Color4B(197,158,171,120)), 1, Color4F(GameSceneData::CIRCLE_COLOR));
	
}

void RectDrawNode::RedrawRect(ShapeModel::Shape shape, RectDrawNode::DrawType type){
	switch (type) {
  case DrawType::LIFE_CIRCLE:
			
			redraw(shape, Color4F(GameSceneData::CIRCLE_COLOR));
			break;
		case DrawType::ROUND_CIRCLE:
			redraw(shape, Color4F(GameSceneData::ROUND_CIRCLE_COLOR));
			break;
			
  default:
			break;
	}
}

void RectDrawNode::redraw(ShapeModel::Shape shape, cocos2d::Color4F color){
	//	清空画布
	this->clear();
	
	//	绘制小方块
	for (int i = 0; i < LENGTH; ++i) {
		for (int j = 0; j < LENGTH; ++j) {
			if (shape.shape[i][j] == 1) {
				
				Vec2 point[4];
				point[0] = getDrawPosAt(i, j);
				point[1] = getDrawPosAt(i, j+1);
				point[2] = getDrawPosAt(i+1,j+1);
				point[3] = getDrawPosAt(i+1	,j);
				
				this->drawPolygon(point, 4, color, 3, Color4F(1,0,0,0));
			}
		}
	}
	
	//	绘制限定表现
	
	Vec2 point[4];
	point[0] = getDrawPosAt(0, 0);
	point[1] = getDrawPosAt(0, LENGTH);
	point[2] = getDrawPosAt(LENGTH, LENGTH);
	point[3] = getDrawPosAt(LENGTH, 0);
	
	this->drawPolygon(point, 4, Color4F(Color4B(197,158,171,120)), 1, color);
}
/////////////////////////////////////////////////////
Vec2 RectDrawNode::getDrawPosAt(int i, int j){
	
	CCASSERT(0<=i&&i<=LENGTH,"RectDrawNode::getDrawPosAt   (i)  out of range!!");
	CCASSERT(0<=j&&j<=LENGTH,"RectDrawNode::getDrawPosAt   (j)  out of range!!");
	
	return getDrawPosAt(i, j, LENGTH);
}

Vec2 RectDrawNode::getDrawPosAt(int i, int j, int order){

	
	double x = delWidth * i / order + (width - 2 * (delWidth * i / order))* j / order;
	double y = (order - i)*height/order;
	
	return Vec2(x,y);
}