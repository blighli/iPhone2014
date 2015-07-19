//
//  GameEngineViewController.h
//  Fissure
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelManager.h"
#import "GameScene.h"

@interface GameViewController : UIViewController <GameSceneDelegate>  {
    // sk视图
    SKView *sceneView;
    
    //视图
    GameScene *scene;
    
    //菜单和按钮
    UIButton *menuButton;
    UIButton *restartButton;
    
    //*
    UIButton *snapButton;
    UIButton *nextButton;
    
    //当前关卡
    NSString *currentLevelId;
    
    //关数菜单
    UIView *levelMenuView;
    NSMutableArray *levelButtons;
    NSMutableArray *starImageViews;
    NSString *menuToLevelId;
    UIImageView *titleImage;
    
}
SINGLETON_INTR(GameViewController);
@end
