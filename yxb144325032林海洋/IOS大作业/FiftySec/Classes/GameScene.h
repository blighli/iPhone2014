#ifndef __GAMESCENE_H__
#define __GAMESCENE_H__

#include "cocos2d.h"
#include "MyRes.h"
#include "End.h"
USING_NS_CC;

class GameScene:public LayerColor
{
public:
	//bool init();
	virtual bool initWithColor(const Color4B& color);
	//virtual void onEnter();
	static Scene *createScene(const Color4B& color);//scene

	//CREATE_FUNC(GameScene);
	static GameScene* create(const Color4B& color, PhysicsWorld *_world);//layer
	
	void paramInit();
	void addbackground();
	void addEdges();
	void addblocks();
	void addControlBlock();
	void setPhyWorld(PhysicsWorld *_world);
	void addGradelabel();
	int getcurtime();
	virtual void update(float dt);

private:
	Size visibleSize;
	Vec2 origin;
	Sprite *bac;
	PhysicsBody *edge;
	PhysicsWorld*world;

	Sprite *rocker;//control
	Sprite*block[4];
	Vec2 block_init_pos[4];
	Vect  block_init_des[4];

	int count;
	bool isGameStart;
	int sec_start;
	//int sec_end;
	int grade;
	LabelTTF *label_grade;
};

#endif