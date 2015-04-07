//
//  ShapeModel.cpp
//  ShapeModel
//
//  Created by StarJade on 14-11-29.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#include "ShapeModel.h"
#include <stdlib.h>
#include "cocos2d.h"

ShapeModel *singleModel = NULL;
ShapeModel::ShapeModel(){
	
	// 初始化两个形状
	initSpinShapesAndMoveShape();

	
	// 旋转图形的初始状态
	state = ShapeModel::EnAngle::BASIC;
	
	// 创建fullShape
	
	for (int i = 0; i < LENGTH; ++i) {
		for (int j = 0; j < LENGTH; ++j) {
			
			fullShape.shape[i][j] = 1;
		}
	}
	
}

ShapeModel::~ShapeModel(){
	
}



ShapeModel *ShapeModel::sharedModel(){
	if(singleModel == NULL){
		singleModel = new ShapeModel();
	}
	return singleModel;
}

ShapeModel::Shape ShapeModel::resetMoveShape(){

//	// 产生随机数
//	static int count = 0;// 即使短时间再次调用依旧能产生随机效果
//	srandom((unsigned int)time(0)+count*5);
//	++count;
//	
//	int rand = random()%LOOP;
	
	
	
	int rand = arc4random()%LOOP;

	
	
	
	// 初始化移动图形
	Shape shape;
	for (int i = 0; i < LENGTH; ++i) {
		for (int j = 0; j < LENGTH; ++j) {
			if (basicShape[rand].shape[i][j] == 0) {
				if (random() % 2 == 0) {
					shape.shape[i][j] = 1;
				}
			}
		}
	}
	moveShape = shape;
	
	return moveShape;
	
}

void ShapeModel::resetSpinShapes(){
	for (int i = 0; i < LENGTH; ++i) {
		for (int j = 0; j < LENGTH; ++j) {
			int isdot = random() % 2;
			int max = LENGTH - 1;
//			basicShape[0].shape[i][j] = isdot;
//			basicShape[1].shape[max - j][i] = isdot;
//			basicShape[2].shape[max - i][max - j] = isdot;
//			basicShape[3].shape[j][max - i] = isdot;
			
			basicShape[0].shape[i][j] = isdot;
			basicShape[1].shape[j][max - i] = isdot;
			basicShape[2].shape[max - i][max - j] = isdot;
			basicShape[3].shape[max - j][i] = isdot;
		}
	}
}

void ShapeModel::resetSpinShapesAndMoveShape(){
	// 顺序不可变
	resetSpinShapes();
	resetMoveShape();
}
/////////////获取形状///////////////////////////////////

ShapeModel::Shape ShapeModel::getSpinShape(){
	return basicShape[state];
}

ShapeModel::Shape ShapeModel::getMoveShape(){
	return moveShape;
}
ShapeModel::Shape ShapeModel::getFullShape(){
	return fullShape;
}
ShapeModel::Shape ShapeModel::getOverlapShape(){
	return overlapShape;
}
/////////////旋转操作///////////////////////////////////

void ShapeModel::rotate(){
	state = (EnAngle)(((int)state + 1)%LOOP);
}

void ShapeModel::antiRotate(){
	for (int i = 1 ; i <= LOOP - 1; ++i) {
		rotate();
	}
}

/////////////重叠检测///////////////////////////////////

bool ShapeModel::isOverlap(){
	
	int stateInt = (int)state;
	bool isOverlap = false;
	
	for (int i = 0; i < LENGTH; ++i) {
		for (int j = 0; j < LENGTH; ++j) {
			overlapShape.shape[i][j] = 0; //初始化
			
			if (basicShape[stateInt].shape[i][j]
				+ moveShape.shape[i][j] > 1) {
				
				isOverlap = true;//发生了碰撞
				
				overlapShape.shape[i][j] = 1;//生成重叠形状
				printf("\n\n发生重叠：（%d,%d）\n\n",i,j);
			}
		}
	}
	return isOverlap;
	
}
