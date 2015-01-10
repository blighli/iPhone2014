//
//  RectDrawNode.h
//  BlockJourney
//
//  Created by StarJade on 14-12-6.
//
//
/************************************
 *功能：提供一个绘图结点，能够对结点进行重绘
 *
 ************************************/
#ifndef __BlockJourney__RectDrawNode__
#define __BlockJourney__RectDrawNode__

#include <stdio.h>
#include "heads.h"
#include "cocos2d.h"


class RectDrawNode: public cocos2d::DrawNode {

private:
	const int WIDTH = 500;// 矩形圈的宽度
	const int HEIGHT = 300;// 矩形圈的长度
	
	//	3D下的图形长和宽
	const int WIDTH_3D = 406;
	const int HEIGHT_3D = HEIGHT;
	
protected:
	cocos2d::Vec2 blockPos[LENGTH][LENGTH];//生命框中每个小方块的中点位置
public:
	enum DrawType{
		LIFE_CIRCLE,
		ROUND_CIRCLE,
	};
	
public:
	bool init();
	CREATE_FUNC(RectDrawNode);
	
	
protected:
	void RedrawRect(ShapeModel::Shape shape);
	void RedrawRect(ShapeModel::Shape shape,DrawType type);
	
	
private:
	const double DEL_WIDTH = (WIDTH - WIDTH_3D)/2;
	float width;
	float height;
	float delWidth;
	
private:
	cocos2d::Vec2 getDrawPosAt(int i, int j);// 根据坐标给出绘制位置
	cocos2d::Vec2 getDrawPosAt(int i, int j,int order);//根据位置和阶数给出位置
	void redraw(ShapeModel::Shape shape,cocos2d::Color4F color);
};

#endif /* defined(__BlockJourney__RectDrawNode__) */
