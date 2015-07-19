//
//  GameViewController.m
//  FissureGame
//
//  Created by xiaoo_gan on 12/18/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "GameViewController.h"

#define MENU_SIZE_RATIO         0.85

#define NUM_LEVELS              36
#define NUM_LEVEL_ROWS          6
#define NUM_LEVEL_COLS          6
#define MENU_BUTTON_VERT_INSET  10
#define MENU_BUTTON_HORZ_INSET  10

@implementation SKScene (Unarchive)

//+ (instancetype)unarchiveFromFile:(NSString *)file {
//    /* Retrieve scene file path from the application bundle */
//    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
//    /* Unarchive the file to an SKScene object */
//    NSData *data = [NSData dataWithContentsOfFile:nodePath
//                                          options:NSDataReadingMappedIfSafe
//                                            error:nil];
//    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    [arch setClass:self forClassName:@"SKScene"];
//    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
//    [arch finishDecoding];
//    
//    return scene;
//}

@end

@implementation GameViewController

SINGLETON_IMPL(GameViewController);

//- (void) viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    SKView *skView = (SKView *) self.view;
//    if (!skView.scene) {
//        skView.showsFPS = YES;
//        skView.showsNodeCount = YES;
//        GameScene *scene = [GameScene sceneWithSize:skView.bounds.size];
//        scene.scaleMode = SKSceneScaleModeAspectFill;
//        [skView presentScene:scene];
//    }
//}

- (id) init {
    if ((self = [super init])) {
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                                                   [UIScreen mainScreen].bounds.size.height)];
        self.view.backgroundColor = [UIColor clearColor];                 //设置背景色
        sceneView = [[SKView alloc] initWithFrame:self.view.bounds];
        sceneView.showsFPS = NO;                                        //不显示帧速
        sceneView.showsNodeCount = NO;                                  //不显示节点数
        sceneView.showsDrawCount = NO;
        [self.view addSubview:sceneView];                               //添加到视图中

        scene = [[GameScene alloc] initWithSize:self.view.bounds.size]; //加载场景
        scene.sceneDelegate = self;                                     //设置场景代理
        [sceneView presentScene:scene];                                 //显示场景

        
        //加载菜单按钮
        menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.frame = CGRectMake(self.view.bounds.size.width - 40, 0, 40, 40);
        [menuButton addTarget:self                          //添加菜单按钮事件
                       action:@selector(pressedMenu:)
             forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuButton];                  //菜单按钮添加到视图中
        UIImageView *mImage = [[UIImageView alloc]          //菜单按钮图标
                               initWithImage:[UIImage imageNamed:@"icon_menu"]];
        mImage.frame = CGRectMake(15, 5, 20, 20);
        mImage.alpha = 1.0;
        [menuButton addSubview:mImage];                     //为菜单设置图标

        //加载重新开始按钮
        restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        restartButton.frame = CGRectMake(self.view.bounds.size.width - 40,
                                         self.view.bounds.size.height - 40, 40, 40);
        [restartButton addTarget:self                       //添加按钮事件
                          action:@selector(pressedRestart:)
                forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:restartButton];               //将重新开始按钮添加到视图中
        UIImageView *rImage = [[UIImageView alloc]          //重新开始按钮图标
                               initWithImage:[UIImage imageNamed:@"icon_restart"]];
        rImage.frame = CGRectMake(15, 15, 20, 20);
        rImage.alpha = 1.0;                                 //图标透明度
        [restartButton addSubview:rImage];                  //为按钮设置图标
        
        
        
        //加载关卡菜单视图
        levelButtons = [ NSMutableArray array];             //关卡图标数组
        starImageViews = [NSMutableArray array];            //星星图标数组
        
        levelMenuView = [[UIView alloc] initWithFrame:self.view.bounds];   //视图大小
        levelMenuView.alpha = 0;                            //默认不显示，按下关卡菜单才显示
        levelMenuView.backgroundColor = [UIColor colorWithWhite:1
                                                          alpha:1]; //背景颜色
        [self.view addSubview:levelMenuView];               //加载到视图
        
        //关卡菜单视图头部
        titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title"]];
        titleImage.center = CGPointMake(self.view.bounds.size.width / 2, 29);
        [levelMenuView addSubview:titleImage];
        
        //关闭关卡菜单视图
        UIButton *closeMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        closeMenu.frame = levelMenuView.bounds;             //frame为整个视图
        [closeMenu addTarget:self                           //添加按钮事件
                      action:@selector(pressedCloseMenu:)
            forControlEvents:UIControlEventTouchDown];
        [levelMenuView addSubview:closeMenu];
        
        //关卡区域宽度，高度
        int menuWidth = self.view.bounds.size.width * MENU_SIZE_RATIO;
        int menuHeight = self.view.bounds.size.height * MENU_SIZE_RATIO;
        
        int initialXOffset = (self.view.bounds.size.width - menuWidth) / 2;
        int initialYOffset = self.view.bounds.size.height - menuHeight;
        
        //关卡按钮宽度，高度         6 X 6
        int buttonWidth = (menuWidth - (NUM_LEVEL_COLS + 1) * MENU_BUTTON_HORZ_INSET) / NUM_LEVEL_COLS;
        int buttonHeight = (menuHeight - (NUM_LEVEL_ROWS + 1) * MENU_BUTTON_VERT_INSET) / NUM_LEVEL_ROWS;
        
        int buttonOffSetX = buttonWidth + MENU_BUTTON_HORZ_INSET;
        int buttonOffSetY = buttonHeight + MENU_BUTTON_VERT_INSET;
        
        //加载每个关卡按钮
        int levelIndex = 0;
        for (int r = 0; r < NUM_LEVEL_ROWS; r ++) {
            for (int c = 0; c < NUM_LEVEL_ROWS; c ++) {
                UIButton *levelButton = [UIButton buttonWithType:UIButtonTypeCustom];
                levelButton.backgroundColor = [UIColor  colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];;     //按钮背景颜色
                levelButton.frame = CGRectMake(c * buttonOffSetX + MENU_BUTTON_HORZ_INSET + initialXOffset,
                                               r * buttonOffSetY + MENU_BUTTON_VERT_INSET + initialYOffset,
                                               buttonWidth, buttonHeight); //关卡位置
                NSString *levelName = [[LevelManager sharedInstance] levelIdAtPosition:levelIndex];
               // int dim = ([UIScreen mainScreen].bounds.size.height < 482) ? 480 : 568;
                //关卡图标
                UIImage *bImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", levelName]];
                
                [levelButton setImage:bImage forState:UIControlStateNormal];    //为关卡按钮设置图标
                
                levelButton.tag = levelIndex;                   //设置按钮的tag
                
                [levelButton addTarget:self                     //为关卡按钮添加点击事件
                                action:@selector(pressedLevel:)
                      forControlEvents:UIControlEventTouchUpInside];
                
                //
                
                levelButton.layer.shadowColor = [UIColor blackColor].CGColor;
                levelButton.layer.shadowOffset = CGSizeMake(0, 0);
                levelButton.layer.shadowOpacity = 0.5;
                levelButton.layer.shadowRadius = 2;
                levelButton.layer.shouldRasterize = YES;
                levelButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
                
                //添加到关卡视图
                [levelMenuView addSubview:levelButton];
                [levelButtons addObject:levelButton];
                levelIndex ++;
                
                // 星星
                UIImageView *star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star-mini"]];
                star.center = CGPointMake(buttonWidth - 2, buttonHeight - 3);
                [levelButton addSubview:star];
                [starImageViews addObject:star];
                
            }
        }
        //加载关卡地图
        [self loadLevelId:[LevelManager sharedInstance].currentLevelId];
    }
    return self;
}

//更新星星的显示
- (void) updateStars {
    int index = 0;
    for (UIImageView *star in starImageViews) {
        NSString *levelId = [[LevelManager sharedInstance] levelIdAtPosition:index];
        if ([[LevelManager sharedInstance] isComplete:levelId]) {
            //该关卡已完成，则显示星星
            star.alpha = 1;
        } else {
            star.alpha = 0;
        }
        index ++;
    }
}
- (void) pressedMenu: (UIButton *) button {
    //NSLog(@"菜单按钮被按下");
    [self updateStars];
    
    titleImage.alpha = 0;   //关卡视图头部不可见
    
    [UIView animateWithDuration:0.5                 //显示关卡视图头部
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         titleImage.alpha = 1;
                     } completion:nil];
    
    //显示关卡按钮
    for (UIButton *button in levelButtons) {
        button.alpha = 0;                           //关卡按钮不可见
        float delay = 0.2 + floatBetween(0, 0.25); //随机延迟显示
        [UIView animateWithDuration:0.5                 //显示关卡按钮
                              delay:delay
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             button.alpha = 1;
                         } completion:nil];
        
        
        //设置关卡按钮特效
        SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:@"transfrom"];
        bounceAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)];
        bounceAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        bounceAnimation.duration = 0.5f;
        bounceAnimation.beginTime = CACurrentMediaTime() + delay + 0.1;
        bounceAnimation.removedOnCompletion = NO;
        bounceAnimation.fillMode = kCAFillModeBackwards;
        bounceAnimation.numberOfBounces = 3;
        bounceAnimation.stiffness = SKBounceAnimationStiffnessLight;
        
        [button.layer addAnimation:bounceAnimation forKey:nil];
    }
    
    // 显示关卡菜单视图
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{ levelMenuView.alpha = 1;}
                     completion:nil];
}

- (void) pressedCloseMenu: (UIButton *) button {
    //NSLog(@"菜单关闭按钮被按下");
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{ levelMenuView.alpha = 0;}
                     completion:nil];
}

- (void) pressedRestart: (UIButton *) button {
    //NSLog(@"重新开始按钮被按下");
    [scene resetControlsToInitialPositions];
}


- (void) pressedLevel: (UIButton *) button {
    //关卡地图名称
    menuToLevelId = [[LevelManager sharedInstance] levelIdAtPosition:(SInt32)button.tag];
    //NSLog(@"关卡按钮 %d 被按下,关卡地图名称：%@", button.tag, menuToLevelId);
    [scene forceWin];                //强制进入选择的关卡
    [self pressedCloseMenu:nil];
}

//隐藏状态栏
- (BOOL) prefersStatusBarHidden {
    return YES;
}

#pragma mark -  GameSceneDelegate methods


//
- (void) sceneAllTargetsLit {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    //NSLog(@"进入的关卡地图名称：%@",menuToLevelId);
    if (!menuToLevelId) {
        [[LevelManager sharedInstance] setComplete:currentLevelId];
        [self updateStars];
//         [Flurry logEvent:@"Beat_Level"
//          withParameters:@{@"levelId":currentLevelId}];
    }
}

//加载关卡地图数据
- (void) loadLevelId:(NSString *) levelId {
    currentLevelId = levelId;
    NSDictionary *levelDic = [[LevelManager sharedInstance] levelDictionaryForId:currentLevelId];
    [scene loadFromLevelDictionary:levelDic];
    //NSLog(@"加载关卡：%@", currentLevelId);
    [LevelManager sharedInstance].currentLevelId = levelId;
}



//准备转换场景
- (void) sceneReadyToTransition {
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    if (menuToLevelId) {                    //不为nil，表示是通过关卡选择菜单，进入相应的关卡
        [self loadLevelId:menuToLevelId];   //加载选择的关卡地图
        menuToLevelId =nil;
    } else {                                //完成这一关卡，进入下一关卡
        int currentLevelNum = [[LevelManager sharedInstance] levelNumForId:currentLevelId];
        currentLevelNum = (currentLevelNum + 1) % [LevelManager sharedInstance].levelCount;
        [self loadLevelId:[[LevelManager sharedInstance] levelIdAtPosition:currentLevelNum]];
    }
}

@end


































