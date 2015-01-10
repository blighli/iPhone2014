//
//  ShapeModel.h
//  ShapeModel
//
//  Created by StarJade on 14-11-29.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

/************************************
 *处理3*3矩阵的图形数据
 *
 *无输入
 *提供生产、改变、检测、以及reset功能
 ************************************/

/************************************
 *待实现功能 TODO
 *1、旋转图形为空或者移动图形为空的情况
 *2、答案解的数量控制
 *
 ************************************/
#ifndef __ShapeModel__ShapeModel__
#define __ShapeModel__ShapeModel__

#include <stdio.h>
#include <string>

#define LENGTH 3
#define LOOP 4	// 转4次一个循环// warn含有loop无法控制的代码

using namespace std;

class ShapeModel
{
	
public:
	ShapeModel();
	~ShapeModel();
	
public:
    
    // 基本形状的数据结构
    struct Shape{
        bool shape[LENGTH][LENGTH];
        
        Shape(){
            memset(shape, 0, sizeof(shape));
        }
		
		void init(int *a){
			
			
			// 初始化
			for(int i=0;i<LENGTH*LENGTH;++i){
				shape[i/LENGTH][i%LENGTH]= a[i];
			}
		}
        
    };
    
    enum EnAngle{
        BASIC = 0,
        ONCE,
        TWICE,
		        
    }state;
private:
	Shape basicShape[LOOP];// 每个角度下的基本形状
    Shape moveShape;
	
	Shape fullShape;
	
	Shape overlapShape;
	
private:
	
	void resetSpinShapes();
	
	void initSpinShapesAndMoveShape(){
		resetSpinShapesAndMoveShape();
	}
	
public:
	static ShapeModel *sharedModel();// 得到模型的单例
	
	// 重置形状
	void resetSpinShapesAndMoveShape();//避免单独调用出错
    Shape resetMoveShape();
	
	// 提供形状
	Shape getMoveShape();
	Shape getSpinShape();
	Shape getFullShape();
	Shape getOverlapShape();
	
    void rotate();/*顺时针转90°*/
    void antiRotate();/*逆时针转90°*/
    
    bool isOverlap();/*判断当前形状和移动形状是否重叠*/
    
    
    
    
};


#endif /* defined(__ShapeModel__ShapeModel__) */
