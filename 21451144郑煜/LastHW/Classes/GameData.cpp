//
//  GameData.cpp
//  BlockJourney
//
//  Created by StarJade on 14-12-9.
//
//

#include "public.h"


static GameData *gameData = nullptr;


GameData *GameData::sharedGameData(){
	if (gameData == nullptr) {
		gameData = new GameData();
	}
	return gameData;
}

GameData::GameData(){

	comprehendMap[1] = "初识";
	comprehendMap[2] = "新奇";
	comprehendMap[3] = "迷梦";
	comprehendMap[4] = "探索";
	comprehendMap[5] = "奋斗";
	comprehendMap[6] = "觉察";
	
	comprehendMotto[1] = "新的世界展现在眼前";//该句应当不会出现 TODO
	comprehendMotto[2] = "风从体内吹过去，\n刮走多年艰辛的闷气，\n\n在这片清新的土地上，\n重拾新奇。";
	comprehendMotto[3] = "不记得前世，\n不知道来生，\n只是在虚空中不断地前行。";
	comprehendMotto[4] = "你跳不出这个世界，\n是因为你不知道它有多大。";
	comprehendMotto[5] = "芒鞋斗笠千年走，\n万古长空一朝游，\n\n追梦而行，\n物我两忘。";
	comprehendMotto[6] = "若是不悟，\n千里万里也是枉然，\n\n若是悟了，\n脚下便是灵山。";
	
	remnantMap[1] = BASIC_NEEDS;
	remnantMap[2] = BASIC_NEEDS * 0.9;
	remnantMap[3] = BASIC_NEEDS * 1.8;
	remnantMap[4] = BASIC_NEEDS * 1.5;
	remnantMap[5] = BASIC_NEEDS * 2.1;
	remnantMap[6] = BASIC_NEEDS * 2.0;
	
	
	
	// 载入游戏数据
	
	remnants = 0;
	lifeRounds = 0;
	comprehend = UserDefault->getIntegerForKey("领悟等级", 1);
	maxLifeRounds = UserDefault->getIntegerForKey("最长历世",0);
	maxComprehend = comprehend;
	

	
	
}

GameData::~GameData(){
	// 存储游戏数据
	UserDefault->setIntegerForKey("领悟等级",maxComprehend);
	UserDefault->setIntegerForKey("最长历世", maxLifeRounds);
	//长久存储
	UserDefault->flush();
}


string GameData::getRemnants(){
	return StringUtils::toString(remnants);
}

string GameData::getComprehend(){

	return comprehendMap[comprehend];
}
string GameData::getLifeRounds(){
	
	return StringUtils::toString(lifeRounds);

}

string GameData::getMaxLifeRounds(){
	return StringUtils::toString(maxLifeRounds);
}

string GameData::getMotto(){
	return comprehendMotto[maxComprehend];
}
string GameData::getMaxComprehend(){
	return comprehendMap[maxComprehend];

}

//bool GameData::isComprehendUp(){
//	return (comprehend > maxComprehend);
//}
//
//bool GameData::isLifeRoundsUp(){
//	return (lifeRounds > maxLifeRounds);
//}

float GameData::getComprehendProgress(){
	return ((float)remnants/remnantMap[comprehend]);

}

void GameData::addRound(){
	++lifeRounds;
	
	// TODO 根据生命框与轮回框的间隙加分
	
	remnants += 10;
	
	if (remnants >= remnantMap[comprehend]) {
		if (comprehend < 6){
			++comprehend;
			remnants = 0;
		}else{
			remnants = remnantMap[comprehend];
		}
		
	}
}

bool GameData::updateMaxLifeRounds(){
	if (lifeRounds > maxLifeRounds) {
		maxLifeRounds = lifeRounds;
		
		UserDefault->setIntegerForKey("最长历世", maxLifeRounds);
		//长久存储
		UserDefault->flush();
		return true;
	}
	return false;
}

bool GameData::updateMaxComprehend(){
	if (comprehend > maxComprehend) {
		maxComprehend = comprehend;
		
		
		UserDefault->setIntegerForKey("领悟等级",maxComprehend);
		//长久存储
		UserDefault->flush();
		return true;
	}
	return false;
}

void GameData::reset(){
	// 初始化
	remnants = 0;
	lifeRounds = 0;
}


