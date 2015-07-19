#include "MenuLayer.h"
#include "GameScene.h"
#include "GameData.h"
#include "Audio.h"
#include "MenuScene.h"
bool MenuLayer::init(){
	if(!Layer::init()){
		return false;
	}

	Size visibleSize = Director::getInstance()->getVisibleSize();
	/*放置背景*/
	Sprite* background = Sprite::create("bg_menuscene.jpg");
	background->setPosition(visibleSize.width/2,visibleSize.height/2);
	this->addChild(background,-1);
	
	/*初始化菜单*/
	MenuItemImage* startBtn = MenuItemImage::create(
		"menu_start.png","menu_star.png",CC_CALLBACK_0(MenuLayer::startGame,this)
		);
    
    //继续按钮
    MenuItemImage* continueBtn = MenuItemImage::create("menu_continue.png","menu_continue.png",CC_CALLBACK_0(MenuLayer::ContinueGame, this));
    
    //结束按钮
//    auto endbtn = MenuItemImage::create("menu_continuegame.png", "menu_continuegame.png", CC_CALLBACK_0(MenuLayer::endGame, this));

    Menu* menu = Menu::create(startBtn,continueBtn,NULL);
    menu->alignItemsVertically();
    menu->setPosition(visibleSize.width/2,visibleSize.height/2);
    this->addChild(menu);
 

	return true;
}

void MenuLayer::startGame(){
	CCLOG("START!");
	GAMEDATA::getInstance()->init();
    Director::getInstance()->popToRootScene();
	Director::getInstance()->replaceScene(GameScene::create());

}
void MenuLayer::ContinueGame(){
    CCLOG("CONTINUE!");
 
        Director::getInstance()->popScene();
}

//void MenuLayer::endGame(){
//    CCLOG("END");
//    
//    Director::getInstance()->end();
//}
