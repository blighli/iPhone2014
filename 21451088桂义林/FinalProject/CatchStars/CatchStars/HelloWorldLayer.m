//
//  HelloWorldLayer.m
//  CatchStars
//
//  Created by YilinGui on 14-12-19.
//  Copyright Yilin Gui 2014年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "SimpleAudioEngine.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self = [super init]) ) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgm2.mp3" loop:YES];
        [CDAudioManager sharedManager].backgroundMusic.volume = 0.3f;
        [self initData];
        [self loadBackground];
        [self loadStarAndBomb];
        [self scheduleUpdate];
        // 定义一个计时器
        [self schedule:@selector(gameTimer) interval:1.0];
	}
	return self;
}

#pragma mark - 页面刷新
// 页面刷新
- (void)update:(ccTime)delta {
    // 移动背景
    [self scrollBackground];
    if (isGamePause) {
        [yellowStar stopAllActions];
        [bomb stopAllActions];
    }
    else if (!isGameOver) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        if ([yellowStar visible] && 0 == [yellowStar numberOfRunningActions]) {
            // 有一定概率变成炸弹
            if (CCRANDOM_0_1() < 0.2) {
                [yellowStar setVisible:NO];
                [bomb setPosition:yellowStar.position];
                [bomb setVisible:YES];
            } else {
                CGPoint targetPoint = ccp(size.width * CCRANDOM_0_1(), size.height * CCRANDOM_0_1());
                targetPoint.x = (targetPoint.x > size.width) ? size.width - 30 : targetPoint.x;
                targetPoint.x = (targetPoint.x < 0) ? 30 : targetPoint.x;
                targetPoint.y = (targetPoint.y > size.height) ? size.height - 30 : targetPoint.y;
                targetPoint.y = (targetPoint.y < 0) ? 30 : targetPoint.y;
                float time = ccpDistance(targetPoint, yellowStar.position) / starSlowSpeed;
                id action = [CCMoveTo actionWithDuration:time position:targetPoint];
                [yellowStar runAction:action];
            }
        }
        
        if ([bomb visible]) {
            ++bombTimeCnt;
            //NSLog(@"%d", bombTimeCnt);
            if (bombTimeCnt >= bombTime) {
                bombTimeCnt = 0;
                [bomb setVisible:NO];
                [yellowStar setPosition:bomb.position];
                [yellowStar setVisible:YES];
            }
        }
        if ([bomb visible] && 0 == [bomb numberOfRunningActions]) {
            CGPoint targetPoint = ccp(size.width * CCRANDOM_0_1(), size.height * CCRANDOM_0_1());
            targetPoint.x = (targetPoint.x > size.width) ? size.width - 10 : targetPoint.x;
            targetPoint.x = (targetPoint.x < 0) ? 5 : targetPoint.x;
            targetPoint.y = (targetPoint.y > size.height) ? size.height - 10 : targetPoint.y;
            targetPoint.y = (targetPoint.y < 0) ? 5 : targetPoint.y;
            float time = ccpDistance(targetPoint, bomb.position) / starSlowSpeed;
            id action = [CCMoveTo actionWithDuration:time position:targetPoint];
            [bomb runAction:action];
        }
    }
}

#pragma mark - 初始化数据
// 初始化数据
- (void)initData {
    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
    // 标题
    gameTitleLabel = [CCLabelTTF labelWithString:@"Catch The Star" fontName:@"Marker Felt" fontSize:36];
    // position the label on the center of the screen
    gameTitleLabel.position =  ccp( size.width / 2 , size.height * 0.7 );
    // add the label as a child to this Layer
    [self addChild: gameTitleLabel z:1];
    
    // 创建主菜单菜单项
    CCLabelTTF *startLabel = [CCLabelTTF labelWithString:@"New Game" fontName:@"Marker Felt" fontSize:20];
    CCMenuItem *startMenuItem = [CCMenuItemFont itemWithLabel:startLabel target:self selector:@selector(gameStart)];
    
    CCLabelTTF *helpLabel = [CCLabelTTF labelWithString:@"Help" fontName:@"Marker Felt" fontSize:20];
    CCMenuItem *helpMenuItem = [CCMenuItemFont itemWithLabel:helpLabel target:self selector:@selector(gameHelp)];

    CCLabelTTF *leadLabel = [CCLabelTTF labelWithString:@"Leader Board" fontName:@"Marker Felt" fontSize:20];
    CCMenuItem *leadMenuItem = [CCMenuItemFont itemWithLabel:leadLabel target:self selector:@selector(gameLeaderBoard)];
    
    // 创建主菜单
    mainMenu = [CCMenu menuWithItems:startMenuItem, leadMenuItem, helpMenuItem, nil];
    [mainMenu setPosition:ccp( size.width / 2 , size.height * 0.5 )];
    [mainMenu alignItemsVerticallyWithPadding:15];
    [self addChild:mainMenu z:1];
    
    // 创建暂停菜单项
    CCMenuItem *pauseMenuItem = [CCMenuItemImage
                                 itemFromNormalImage:@"GamePause.png" selectedImage:@"GamePause.png"
                                 target:self selector:@selector(gamePause)];
    [pauseMenuItem setAnchorPoint:ccp(0, 1)];
    pauseMenuItem.position = ccp(10, size.height - 10);
    pauseMenu = [CCMenu menuWithItems:pauseMenuItem, nil];
    [pauseMenu setPosition:CGPointZero];
    [pauseMenu setVisible:NO];
    [self addChild:pauseMenu z:1];
    
    // 创建暂停弹出菜单
    pausePopupLabel = [CCLabelTTF labelWithString:@"--PAUSE--" fontName:@"Marker Felt" fontSize:32];
    pausePopupLabel.position = ccp(size.width / 2, size.height * 0.65);
    [self addChild:pausePopupLabel z:2];
    [pausePopupLabel setVisible:NO];
    
    CCLabelTTF *continueLabel = [CCLabelTTF labelWithString:@"Continue" fontName:@"Marker Felt" fontSize:20];
    CCMenuItem *continueMenuItem = [CCMenuItemFont itemWithLabel:continueLabel target:self selector:@selector(gameContinue)];
    
    CCLabelTTF *quitLabel = [CCLabelTTF labelWithString:@"Quit" fontName:@"Marker Felt" fontSize:20];
    CCMenuItem *quitMenuItem = [CCMenuItemFont itemWithLabel:quitLabel target:self selector:@selector(gameQuit)];
    
    pausePopupMenu = [CCMenu menuWithItems:continueMenuItem, quitMenuItem, nil];
    [pausePopupMenu alignItemsVerticallyWithPadding:15];
    [self addChild:pausePopupMenu z:2];
    [pausePopupMenu setVisible:NO];
    
    // 创建游戏结束弹出菜单
    gameOverPopupLabel = [CCLabelTTF labelWithString:@"GAME OVER" fontName:@"Marker Felt" fontSize:32];
    gameOverPopupLabel.position = ccp(size.width / 2, size.height * 0.7);
    [self addChild:gameOverPopupLabel z:2];
    [gameOverPopupLabel setVisible:NO];
    
    yourScoreLabel = [CCLabelTTF labelWithString:@"Your Score: " fontName:@"Marker Felt" fontSize:24];
    yourScoreLabel.position = ccp(size.width / 2, size.height * 0.6);
    [self addChild:yourScoreLabel z:2];
    [yourScoreLabel setVisible:NO];
    
    CCLabelTTF *playAgainLabel = [CCLabelTTF labelWithString:@"Play Again" fontName:@"Marker Felt" fontSize:20];
    CCMenuItem *playAgainMenuItem = [CCMenuItemFont itemWithLabel:playAgainLabel target:self selector:@selector(gameStart)];
    
    CCLabelTTF *shareLabel = [CCLabelTTF labelWithString:@"Share" fontName:@"Marker Felt" fontSize:20];
    CCMenuItem *shareMenuItem = [CCMenuItemFont itemWithLabel:shareLabel target:self selector:@selector(share)];
    
    CCLabelTTF *quit2Label = [CCLabelTTF labelWithString:@"Quit" fontName:@"Marker Felt" fontSize:20];
    CCMenuItem *quit2MenuItem = [CCMenuItemFont itemWithLabel:quit2Label target:self selector:@selector(gameQuit)];

    gameOverMenu = [CCMenu menuWithItems:playAgainMenuItem, shareMenuItem, quit2MenuItem, nil];
    [gameOverMenu alignItemsVerticallyWithPadding:15];
    [gameOverMenu setPosition:ccp(size.width / 2, size.height / 2 - 26)];
    [self addChild:gameOverMenu z:2];
    [gameOverMenu setVisible:NO];
    
    isGameOver = YES;
    isGamePause = NO;
    isShowTitleAndMenu = YES;
    starSlowSpeed = 120.0;
    starFastSpeed = 500.0;
    impactDistance = 30.0;
    adjustmentBG = size.height;
    
    bombTimeCnt = 0;
    bombTime = 45;
    
    // 得分标签
    scoreLabelText = [CCLabelTTF labelWithString:@"SCORE: " fontName:@"Marker Felt" fontSize:18];
    scoreLabelText.position = ccp(size.width - 65, 20);
    [self addChild: scoreLabelText z:1];
    [scoreLabelText setVisible:NO];
    
    scoreInt = 0;
    scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:18];
    scoreLabel.position = ccp(size.width - 20, 20);
    [self addChild: scoreLabel z:1];
    [scoreLabel setVisible:NO];
    
    // 剩余时间标签
    rmnTimeLabelText = [CCLabelTTF labelWithString:@"TIME: " fontName:@"Marker Felt" fontSize:18];
    rmnTimeLabelText.position = ccp(30, 20);
    [self addChild: rmnTimeLabelText z:1];
    [rmnTimeLabelText setVisible:NO];
    
    rmnTime = 30;
    rmnTimeLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:18];
    [rmnTimeLabel setString:[NSString stringWithFormat:@"%d", rmnTime]];
    rmnTimeLabel.position = ccp(65, 20);
    [self addChild:rmnTimeLabel z:1];
    [rmnTimeLabel setVisible:NO];
    
    // 高分榜标签
    leaderBoradLabel = [CCLabelTTF labelWithString:@"LEADER BOARD" fontName:@"Marker Felt" fontSize:32];
    leaderBoradLabel.position =  ccp( size.width / 2 , size.height * 0.7 );
    [self addChild:leaderBoradLabel z:1];
    [leaderBoradLabel setVisible:NO];
    
    leader1 = [CCLabelTTF labelWithString:@"1st: 0" fontName:@"Marker Felt" fontSize:18];
    leader1.position =  ccp( size.width / 2 , size.height * 0.7 - 52);
    [self addChild:leader1 z:1];
    [leader1 setVisible:NO];
    
    leader2 = [CCLabelTTF labelWithString:@"2nd: 0" fontName:@"Marker Felt" fontSize:18];
    leader2.position =  ccp( size.width / 2 , size.height * 0.7 - 82);
    [self addChild:leader2 z:1];
    [leader2 setVisible:NO];
    
    leader3 = [CCLabelTTF labelWithString:@"3rd: 0" fontName:@"Marker Felt" fontSize:18];
    leader3.position =  ccp( size.width / 2 , size.height * 0.7 - 112);
    [self addChild:leader3 z:1];
    [leader3 setVisible:NO];
    
    // 高分榜返回主菜单的菜单
    CCLabelTTF *backLabel = [CCLabelTTF labelWithString:@"Back" fontName:@"Marker Felt" fontSize:18];
    CCMenuItem *backMenuItem = [CCMenuItemFont itemWithLabel:backLabel target:self selector:@selector(backToTitleAndMenu)];
    leadBdBackMenu = [CCMenu menuWithItems:backMenuItem, nil];
    [leadBdBackMenu setPosition:ccp( size.width / 2 , size.height * 0.7 - 142)];
    [leadBdBackMenu setVisible:NO];
    [self addChild:leadBdBackMenu z:1];
    
    AppController *appCtrl = (AppController *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *scores = [appCtrl getScores];
    if ([scores count] >= 3) {
        NSArray *sortedArr = [scores sortedArrayUsingSelector:@selector(compare:)];
        NSRange range;
        range.location = [sortedArr count] - 3;
        range.length = 3;
        scores = [[sortedArr subarrayWithRange:range] mutableCopy];
        [leader1 setString:[NSString stringWithFormat:@"1st: %d", [[scores objectAtIndex:2] intValue]]];
        [leader2 setString:[NSString stringWithFormat:@"2nd: %d", [[scores objectAtIndex:1] intValue]]];
        [leader3 setString:[NSString stringWithFormat:@"3rd: %d", [[scores objectAtIndex:0] intValue]]];
    } else if ([scores count] == 2) {
        NSArray *sortedArr = [scores sortedArrayUsingSelector:@selector(compare:)];
        [leader1 setString:[NSString stringWithFormat:@"1st: %d", [[sortedArr objectAtIndex:1] intValue]]];
        [leader2 setString:[NSString stringWithFormat:@"2nd: %d", [[sortedArr objectAtIndex:0] intValue]]];
        [leader3 setString:@"3rd: 0"];
    } else if ([scores count] == 1) {
        [leader1 setString:[NSString stringWithFormat:@"1st: %d", [[scores objectAtIndex:0] intValue]]];
        [leader2 setString:@"2nd: 0"];
        [leader3 setString:@"3rd: 0"];
    } else {
        [leader1 setString:@"1st: 0"];
        [leader2 setString:@"2nd: 0"];
        [leader3 setString:@"3rd: 0"];
    }
}

#pragma mark - 背景加载与滚动
// 载入背景
- (void)loadBackground {
    CGSize size = [[CCDirector sharedDirector] winSize];
    // 两个背景Sprite
    BG1 = [CCSprite spriteWithFile:@"background.png"];
    [BG1 setAnchorPoint:ccp(0, 0)];
    [BG1 setScaleX:size.width / BG1.textureRect.size.width];
    [BG1 setScaleY:size.height / BG1.textureRect.size.height];
    [BG1 setPosition:ccp(0, 1)];
    [self addChild:BG1 z:0];
    
    BG2 = [CCSprite spriteWithFile:@"background.png"];
    [BG2 setAnchorPoint:ccp(0, 0)];
    [BG2 setScaleX:size.width / BG2.textureRect.size.width];
    [BG2 setScaleY:size.height / BG2.textureRect.size.height];
    [BG2 setPosition:ccp(0, 0)];
    [self addChild:BG2 z:0];
    
    [self setTouchEnabled:YES];
}

// 背景移动
- (void) scrollBackground
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    --adjustmentBG;
    
    if (adjustmentBG <= 0)
    {
        adjustmentBG = size.height;
    }
    
    [BG1 setPosition:ccp(0, adjustmentBG - size.height)];
    [BG2 setPosition:ccp(0, adjustmentBG - 1)];
}

// 显示标题和主菜单
- (void)backToTitleAndMenu {
    [gameTitleLabel setVisible:YES];
    [mainMenu setVisible:YES];
    [self showPausePopupMenu:NO];
    [self showGameOverPopupMenu:NO isTimeUp:NO];
    [pauseMenu setVisible:NO];
    [self showTimeAndScoreLabels:NO];
    [self showLeaderBoard:NO];
    [self showHelpInfo:NO];
}

// 隐藏标题和主菜单
- (void)hideTitleAndMenu {
    [gameTitleLabel setVisible:NO];
    [mainMenu setVisible:NO];
}

#pragma mark - 触摸事件

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    // 游戏结束或暂停时应禁止点击星星/炸弹
    if (isGameOver || isGamePause) {
        return;
    }
    
    if ([yellowStar visible]) {
        float distance = ccpDistance(yellowStar.position, location);
        if (distance < impactDistance) {
            [self playStarSound];
            // 得分
            [self gameScoring];
            
            [yellowStar stopAllActions];
            CGPoint moveVector = ccpSub(yellowStar.position, location);
            CGPoint targetPoint = ccpAdd(location, ccpMult(ccp(moveVector.x / distance, moveVector.y / distance), impactDistance * 5));
            targetPoint.x = (targetPoint.x > size.width) ? size.width - 30 : targetPoint.x;
            targetPoint.x = (targetPoint.x < 0) ? 30 : targetPoint.x;
            targetPoint.y = (targetPoint.y > size.height) ? size.height - 30 : targetPoint.y;
            targetPoint.y = (targetPoint.y < 0) ? 30 : targetPoint.y;
            float time = ccpDistance(targetPoint, yellowStar.position) / starFastSpeed;
            id action = [CCMoveTo actionWithDuration:time position:targetPoint];
            [yellowStar runAction:action];
        }
    } else {
        float distance = ccpDistance(bomb.position, location);
        if (distance < impactDistance * 3) {
            [self playBlastSound];
            [bomb stopAllActions];
            [self gameOverWithTimeUp:NO];
        }
    }
}

- (void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - 加载星星和炸弹

- (void)loadStarAndBomb {
    CGSize size = [[CCDirector sharedDirector] winSize];
    yellowStar = [CCSprite spriteWithFile:@"star.png"];
    bomb = [CCSprite spriteWithFile:@"bomb.png"];
    
    yellowStar.position = ccp(size.width * CCRANDOM_0_1(), size.height * CCRANDOM_0_1());
    [self addChild:yellowStar z:1];
    [yellowStar setVisible:NO];
    
    bomb.position = ccp(size.width * CCRANDOM_0_1(), size.height * CCRANDOM_0_1());
    [self addChild:bomb z:1];
    [bomb setVisible:NO];
    
    helpInfo = [CCSprite spriteWithFile:@"helpinfo.png"];
    helpInfo.position = ccp(size.width / 2, size.height / 2 - 20);
    helpInfo.scale = 1.6;
    [self addChild:helpInfo z:1];
    [helpInfo setVisible:NO];
    
    CCLabelTTF *backLabel = [CCLabelTTF labelWithString:@"Back" fontName:@"Marker Felt" fontSize:18];
    CCMenuItem *backMenuItem = [CCMenuItemFont itemWithLabel:backLabel target:self selector:@selector(backToTitleAndMenu)];
    helpBackMenu = [CCMenu menuWithItems:backMenuItem, nil];
    [helpBackMenu setPosition:ccp( size.width / 2 , size.height * 0.7 - 142)];
    [helpBackMenu setVisible:NO];
    [self addChild:helpBackMenu z:2];
}

#pragma mark - 游戏开始、暂停、结束、帮助等响应函数

- (void)gameStart {
    NSLog(@"game start!");
    [self hideTitleAndMenu];
    isGameOver = NO;
    isGamePause = NO;
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    yellowStar.position = ccp(size.width * CCRANDOM_0_1(), size.height * CCRANDOM_0_1());
    [yellowStar setVisible:YES];
    
    scoreInt = 0;
    [scoreLabel setString:[NSString stringWithFormat:@"%d",scoreInt]];
    [scoreLabelText setVisible:YES];
    [scoreLabel setVisible:YES];
    
    rmnTime = 30;
    [rmnTimeLabel setString:[NSString stringWithFormat:@"%d", rmnTime]];
    [rmnTimeLabelText setVisible:YES];
    [rmnTimeLabel setVisible:YES];
    
    [pauseMenu setVisible:YES];
    
    [self showGameOverPopupMenu:NO isTimeUp:NO];
    [self showPausePopupMenu:NO];
}

- (void)gamePause {
    isGamePause = YES;
    [self showPausePopupMenu:YES];
}

- (void)gameOverWithTimeUp:(BOOL)timeup {
    //NSLog(@"Score: %d", scoreInt);
    AppController *appCtrl = (AppController *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *scores = [appCtrl getScores];
    [scores addObject:[NSNumber numberWithInt:scoreInt]];
    NSArray *newArr;
    if ([scores count] > 3) {
        newArr = [scores sortedArrayUsingSelector:@selector(compare:)];
        NSRange range;
        range.location = [newArr count] - 3;
        range.length = 3;
        scores = [[newArr subarrayWithRange:range] mutableCopy];
    }
    [appCtrl setScores:scores];
    [appCtrl writeScoresToFile];
    
    isGameOver = YES;
    
    [yellowStar setVisible:NO];
    [bomb setVisible:NO];
    
    //[scoreLabelText setVisible:NO];
    //[scoreLabel setVisible:NO];
    
    //[rmnTimeLabelText setVisible:NO];
    //[rmnTimeLabel setVisible:NO];
    
    [pauseMenu setVisible:NO];
    
    [self showGameOverPopupMenu:YES isTimeUp:timeup];
    
    //[self backToTitleAndMenu];
}

- (void)gameRestart {
    
}

- (void)gameHelp {
    NSLog(@"game help!");
//    AppController *appCtrl = (AppController *)[[UIApplication sharedApplication] delegate];
//    NSLog(@"%@", [appCtrl getTestStr]);
    [self hideTitleAndMenu];
    [helpInfo setVisible:YES];
    [helpBackMenu setVisible:YES];
}

- (void)gameOptions {

}

- (void)gameContinue {
    isGamePause = NO;
    [self showPausePopupMenu:NO];
}

- (void)gameQuit {
    isGameOver = YES;
    [yellowStar setVisible:NO];
    [bomb setVisible:NO];
    [self showPausePopupMenu:NO];
    [self showGameOverPopupMenu:NO isTimeUp:NO];
    [self backToTitleAndMenu];
}

#pragma mark - 游戏得分处理

- (void)gameScoring {
    scoreInt += 1;
    [scoreLabel setString:[NSString stringWithFormat:@"%d",scoreInt]];
    [yourScoreLabel setString:[NSString stringWithFormat:@"Your Score: %d", scoreInt]];
}

// 显示高分榜
- (void)gameLeaderBoard {
    AppController *appCtrl = (AppController *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *scores = [appCtrl getScores];
    if ([scores count] >= 3) {
        NSArray *sortedArr = [scores sortedArrayUsingSelector:@selector(compare:)];
        NSRange range;
        range.location = [sortedArr count] - 3;
        range.length = 3;
        scores = [[sortedArr subarrayWithRange:range] mutableCopy];
        [leader1 setString:[NSString stringWithFormat:@"1st: %d", [[scores objectAtIndex:2] intValue]]];
        [leader2 setString:[NSString stringWithFormat:@"2nd: %d", [[scores objectAtIndex:1] intValue]]];
        [leader3 setString:[NSString stringWithFormat:@"3rd: %d", [[scores objectAtIndex:0] intValue]]];
    } else if ([scores count] == 2) {
        NSArray *sortedArr = [scores sortedArrayUsingSelector:@selector(compare:)];
        [leader1 setString:[NSString stringWithFormat:@"1st: %d", [[sortedArr objectAtIndex:1] intValue]]];
        [leader2 setString:[NSString stringWithFormat:@"2nd: %d", [[sortedArr objectAtIndex:0] intValue]]];
        [leader3 setString:@"3rd: 0"];
    } else if ([scores count] == 1) {
        [leader1 setString:[NSString stringWithFormat:@"1st: %d", [[scores objectAtIndex:0] intValue]]];
        [leader2 setString:@"2nd: 0"];
        [leader3 setString:@"3rd: 0"];
    } else {
        [leader1 setString:@"1st: 0"];
        [leader2 setString:@"2nd: 0"];
        [leader3 setString:@"3rd: 0"];
    }
    
    [self hideTitleAndMenu];
    [leaderBoradLabel setVisible:YES];
    [leader1 setVisible:YES];
    [leader2 setVisible:YES];
    [leader3 setVisible:YES];
    [leadBdBackMenu setVisible:YES];
}

#pragma mark - 游戏定时器

- (void)gameTimer {
    if (!isGameOver && !isGamePause) {
        --rmnTime;
        [rmnTimeLabel setString:[NSString stringWithFormat:@"%d", rmnTime]];
        if (rmnTime == 0) {
            [self gameOverWithTimeUp:YES];
        }
    }
}

#pragma mark - 显示游戏暂停和结束菜单

- (void)showPausePopupMenu:(BOOL)flag {
    [pausePopupLabel setVisible:flag];
    [pausePopupMenu setVisible:flag];
}

- (void)showGameOverPopupMenu:(BOOL)flag isTimeUp:(BOOL)timeup {
    if (timeup) {
        [gameOverPopupLabel setString:@"TIME UP"];
    } else {
        [gameOverPopupLabel setString:@"GAME OVER"];
    }
    [gameOverPopupLabel setVisible:flag];
    [gameOverMenu setVisible:flag];
    [yourScoreLabel setVisible:flag];
    
    [self snapshotScreen:self];
}

- (void)showTimeAndScoreLabels:(BOOL)flag {
    [scoreLabel setVisible:flag];
    [scoreLabelText setVisible:flag];
    
    [rmnTimeLabel setVisible:flag];
    [rmnTimeLabelText setVisible:flag];
}

- (void)showLeaderBoard:(BOOL)flag {
    [leaderBoradLabel setVisible:flag];
    [leader1 setVisible:flag];
    [leader2 setVisible:flag];
    [leader3 setVisible:flag];
    [leadBdBackMenu setVisible:flag];
}

- (void)showHelpInfo:(BOOL)flag {
    [helpInfo setVisible:flag];
    [helpBackMenu setVisible:flag];
}

#pragma mark - 音效

- (void)playStarSound {
    [[SimpleAudioEngine sharedEngine] playEffect:@"star.mp3"];
}

- (void)playBlastSound {
    [[SimpleAudioEngine sharedEngine] playEffect:@"blast.mp3"];
}

#pragma mark - ShareSDK

- (void)share {
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDirectory=[paths objectAtIndex:0];
    
    NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:@"saveFore.png"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:savedImagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //[container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}

- (void)snapshotScreen:(CCNode*)node
{
    //取得屏幕大小
    CGSize winSize = [[CCDirector sharedDirector]winSize];
    CCRenderTexture* renderTexture = [CCRenderTexture renderTextureWithWidth:winSize.width
                                                                      height:winSize.height];
    [renderTexture begin];
    [node visit];
    [renderTexture end];
    [renderTexture cleanup];
    UIImage *snapshot = [renderTexture getUIImageFromBuffer];
    NSData *imagedata=UIImagePNGRepresentation(snapshot);
    
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDirectory=[paths objectAtIndex:0];
    
    NSString *savedImagePath=[documentsDirectory stringByAppendingPathComponent:@"saveFore.png"];
    NSLog(@"savepath is %@",savedImagePath);
    
    [imagedata writeToFile:savedImagePath atomically:YES];
}

@end
