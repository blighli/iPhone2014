#ifndef  __END_H__
#define __END_H__

#include "cocos2d.h"
#include "MyRes.h"
USING_NS_CC;

class End : public Layer
{
public:
	static Scene *createScene(int grade);
	virtual bool init();
	//CREATE_FUNC(End);
	static End* create(int grade);
	void addBac();
	void addLabel();
	void addGrade();

	void gameagain(Ref *pSender);
	void gameover(Ref *pSender);
private:
	Size visibleSize;
	Vec2 origin;
	Sprite *bac;
	LabelTTF *label;
	int grade;
};
#endif