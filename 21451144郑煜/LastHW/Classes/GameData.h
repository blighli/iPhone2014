//
//  GameData.h
//  BlockJourney
//
//  Created by StarJade on 14-12-9.
//
//
/************************************
 *功能：存储等级分数系统
 
 *
 *
 
 * 1、提供残念、领悟、历世以及最长历世、最高领悟的获取方法
 
 * 2、提供领悟判断和历世判断
 
 * 3、提供当前残念占领悟的比例
 * 4、提供方法进行历世计数。
 ************************************/
#ifndef __BlockJourney__GameData__
#define __BlockJourney__GameData__

#include "heads.h"

#define UserDefault UserDefault::getInstance()

class GameData {

public:

	std::map<int,std::string> comprehendMap;// 领悟等级与名称对应
	std::map<int,std::string> comprehendMotto;// 领悟等级对应的格言
	std::map<int,int> remnantMap;// 每个领悟等级需要的残念
	const int BASIC_NEEDS = 100;
	
	
	
public:
	GameData();
	~GameData();
	
private:
	int remnants;
	int lifeRounds;
	int comprehend;
	
	int maxLifeRounds;
	int maxComprehend;
	
	
	
public:
	static GameData *sharedGameData();
	
	std::string getRemnants();// 获得残念
	std::string getComprehend(); //获得领悟
	std::string getLifeRounds();//经历轮回数
	std::string getMotto();
	
	std::string getMaxLifeRounds();
	std::string getMaxComprehend();
	
//	bool isComprehendUp();
//	bool isLifeRoundsUp();
	
	float getComprehendProgress();//领悟进度
	
	void addRound();//添加历世计数。
	bool updateMaxLifeRounds();//返回轮回数是否上升
	bool updateMaxComprehend();
	
	void reset();
	
};

#endif /* defined(__BlockJourney__GameData__) */
