#pragma once
#include "cocos2d.h"
#include "cardSprite.h"
#include "MenuLayer.h"
class GameScene :public cocos2d::Layer
{
public:
	static cocos2d::Scene* createScene();
	virtual bool init();
	CREATE_FUNC(GameScene);
public:
	//触摸监听
	virtual bool onTouchBegan(cocos2d::Touch *touch, cocos2d::Event *event); //注意这里要加命名空间作用域cocos2d
	virtual void onTouchEnded(cocos2d::Touch *touch, cocos2d::Event *event);
    //上下左右滑动动作
	bool moveLeft();
	bool moveRight();
	bool moveUp();
	bool moveDown();
	//创建4*4卡片矩阵
	void createCardArr(Size size);
	void randomCreateCard();
	//判断游戏赢输
	void checkGameWin();
	void checkGameOver();
	void restart(Ref *sender); //重新开始游戏菜单项
private:
	int score;  //当前分数
	int bestScore; //最好分数
	bool sound; //声音变量
	cocos2d::LabelTTF *scoreLabel;
	LabelTTF *restartBtn; //重新开始的按钮
	LabelTTF *isSoundBtn; //声音切换按钮
	CardSprite *cardArr[4][4];  //数字卡片矩阵
	CardSprite *cardArrAction[4][4]; //用于动画的临时数字卡片矩阵
	Point startPt; //触摸开始点
	int offsetX, offsetY;  //触摸水平和竖直方向偏移量
	MenuLayer *menuLayer; //菜单层
	timeval tv; //当前时间
};