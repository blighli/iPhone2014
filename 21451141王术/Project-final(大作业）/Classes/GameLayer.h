#ifndef _GAMELAYER_H_
#define _GAMELAYER_H_
#include "cocos2d.h"
#include "FloatWord.h"
#include "TopMenu.h"
#include "StarMatrix.h"
using namespace cocos2d;
class StarMatrix;
class GameLayer : public Layer{
public:
	virtual bool init();
	CREATE_FUNC(GameLayer);
	void floatLevelWord();//飘出关卡信息
	void floatTargetScoreWord();//飘出目标分数
	void removeFloatWord();//移除关卡信息和目标分数
	void showStarMatrix();//创造星星矩阵（所有的星星）
	virtual void update(float delta);//update
	virtual bool onTouchBegan(Touch* touch,Event* event);//接受触摸事件
	void refreshMenu();//刷新顶部信息
	void showLinkNum(int size);//显示连击信息
	void hideLinkNum();//隐藏连击信息
	void floatLeftStarMsg(int leftNum);//显示剩余星星数量
	void gotoNextLevel();//跳到另一关
	void gotoGameOver();//游戏结束
    void MyResume(); //加入暂停
private:
	FloatWord* _levelMsg;//关卡信息（飘字）
	FloatWord* _targetScore; //目标分数（飘字）
	TopMenu* menu;//顶部信息
	StarMatrix* matrix;//所有星星
	Label* linkNum;//连击信息
};
#endif