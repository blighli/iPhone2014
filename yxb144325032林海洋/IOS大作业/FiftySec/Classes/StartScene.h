#ifndef  __STARTSCENE_H__
#define __STARTSCENE_H__
#include "cocos2d.h"
#include "MyRes.h"
USING_NS_CC;

class StartScene:public Layer
{
public:
	static Scene *createScene();
	bool init();
	CREATE_FUNC(StartScene);

	void gamestart(Ref *pSender);
	void gameover(Ref *pSender);

	void addbac();
private:
	Sprite *bac;
	Size visibleSize;
	Vec2 origin;
};

#endif