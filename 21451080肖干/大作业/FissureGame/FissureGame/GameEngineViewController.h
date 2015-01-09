//
//  GameEngineViewController.h
//  Fissure
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FissureScene.h"
#import "MathHelper.h"
#import "Flurry.h"
#import "SingletonHelper.h"

@interface GameEngineViewController : UIViewController <FissureSceneDelegate> {
   // sk视图
    SKView *sceneView;
    
    //视图
    FissureScene *scene;
    
    //菜单和按钮
    UIButton *menuButton;
    UIButton *restartButton;
    
    //*
    UIButton *snapButton;
    UIButton *nextButton;
    
    //当前关数
    NSString *currentLevelId;
    
    //关数菜单
    UIView *levelMenuView;
    NSMutableArray *levelButtons;
    NSMutableArray *starImageViews;
    NSString *menuToLevelId;
    UIImageView *titleImage;
    
}
SINGLETON_INTR(GameEngineViewController);
@end
