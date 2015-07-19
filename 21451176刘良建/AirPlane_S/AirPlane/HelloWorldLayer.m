//
//  HelloWorldLayer.m
//  AirPlane
//
//  Created by JANESTAR on 14-12-15.
//  Copyright JANESTAR 2014年. All rights reserved.
//


// Import the interfaces
#import <ShareSDK/ShareSDK.h>
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

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
	if( (self=[super init]) ) {
        
        gameTitle = [CCLabelTTF labelWithString:@"Plane battles" fontName:@"MarkerFelt-Thin" fontSize:35];
        [gameTitle setPosition:ccp(160, 300)];
        [self addChild:gameTitle z:4];
        
        CCMenuItemFont *gameStart = [CCMenuItemFont itemWithString:@"Start new game" target:self selector:@selector(startnewgame)];
        [gameStart setFontName:@"MarkerFelt-Thin"];
        [gameStart setFontSize:30];
        CCMenuItemFont *about2=[CCMenuItemFont itemWithString:@"About Author" target:self selector:@selector(aboutFunc)];
        [about2 setFontName:@"MarkerFelt-Thin"];
        [about2 setFontSize:30];
        begin = [CCMenu menuWithItems:gameStart,about2,nil];
        [begin alignItemsVerticallyWithPadding:30];
        [begin setPosition:ccp(160, 200)];
        [self addChild:begin z:4];
        
        [self initData];
        [self loadBackground];
        [self loadPlayer];
        // touch事件代理
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

        
        
        
        /*
        
        
        [self initData];
        [self loadBackground];
        [self loadPlayer];
        [self madeBullet];
        [self resetBullet];
        [self setHdBar];
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"game_music.mp3"];
        [self scheduleUpdate];
        
        // touch事件代理
       [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
     
		*/
	}
	return self;
}


-(void)startnewgame{
    [self removeChild:gameTitle];
    [self removeChild:begin];
    CCMenuItem* pauseMenuItem=[CCMenuItemImage itemWithNormalImage:@"BurstAircraftPause.png" selectedImage:@"BurstAircraftPause.png" target:self selector:@selector(gamePause)];
    [pauseMenuItem setAnchorPoint:ccp(0,1)];
    pauseMenuItem.position=ccp(WINDOWWIDTH-50,WINDOWHEIGHT-20);
    starMenu=[CCMenu menuWithItems:pauseMenuItem,nil];
    starMenu.position=CGPointZero;
    [self addChild:starMenu z:4];
    starMenu.tag=10;

    [self madeBullet];
    [self resetBullet];
    [self setHdBar];
    [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"game_music.mp3"];
    [self scheduleUpdate];
    
   

}

-(void)aboutFunc{
   
    [self introduction];


}
-(void)quit{
    UIAlertView* dialog=[[UIAlertView alloc]init];
    [dialog setDelegate:self];
    [dialog setMessage:@"你确定要退出游戏？"];
    [dialog addButtonWithTitle:@"YES"];
    [dialog addButtonWithTitle:@"NO"];
    [dialog show];
 
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0) {
        CCNode *node;
        CCARRAY_FOREACH([self children], node){
            [node stopAllActions];
        }
        [self removeAllChildren];
        [foePlanes removeAllObjects];
        gameTitle = [CCLabelTTF labelWithString:@"Plane battles" fontName:@"MarkerFelt-Thin" fontSize:35];
        [gameTitle setPosition:ccp(160, 300)];
        [self addChild:gameTitle z:4];
        
        CCMenuItemFont *gameStart = [CCMenuItemFont itemWithString:@"Start new game" target:self selector:@selector(startnewgame)];
        [gameStart setFontName:@"MarkerFelt-Thin"];
        [gameStart setFontSize:30];
        CCMenuItemFont *about3=[CCMenuItemFont itemWithString:@"About Author" target:self selector:@selector(aboutFunc)];
        [about3 setFontName:@"MarkerFelt-Thin"];
        [about3 setFontSize:30];
        begin = [CCMenu menuWithItems:gameStart,about3,nil];
        [begin alignItemsVerticallyWithPadding:30];
        [begin setPosition:ccp(160, 200)];
        [self addChild:begin z:4];
        [self unscheduleUpdate];
        
        [self initData];
        [self loadBackground];
        [self loadPlayer];

    }
    else{
        NSLog(@"取消");
    }

}

//制作进度条
-(void)setHdBar{
    CCSprite* sprite=[CCSprite spriteWithFile:@"2.png"];
    CCProgressTimer* ct=[CCProgressTimer progressWithSprite:sprite];
    ct.percentage=0.0f;
    ct.scale=2.0f;
    ct.midpoint=ccp(0, 0.5);
    ct.barChangeRate=ccp(1, 0);
    ct.position=ccp(160,10);
    ct.type=kCCProgressTimerTypeBar;
    ct.percentage=100.0f;
    [self addChild:ct z:4 tag:90];
}



- (void) update:(ccTime)delta {
    if (!isGameOver) {
        [self backgrouneScroll];
        [self firingBullets];
        
        [self addFoePlane];
        [self moveFoePlane];
        [self firingBullets2];
        [self collisionDetection];
        [self makeProps];
        [self bulletTiming];
       
    }
}

-(void)introduction{
    [begin setVisible:NO];
    [starMenu setVisible:NO];
    [player setVisible:NO];
    [gameTitle setVisible:NO];
    about=[CCSprite spriteWithFile:@"t3.jpg"];
    [about setAnchorPoint:ccp(0.5,1)];
    [about setPosition:ccp(160, adjustmentBG)];
    [self addChild:about z:0];
    intro = [CCLabelTTF labelWithString:@"Author: Liangjian Liu\nQQ: 823700867\n SNO:21451176" fontName:@"MarkerFelt-Thin" fontSize:20];
    intro.position=ccp(160,100);
    intro2 = [CCLabelTTF labelWithString:@"IOS大作业\n社交分享功能的飞机大战" fontName:@"MarkerFelt-Thin" fontSize:27];
    intro2.position=ccp(160,450);
    [self addChild:intro];
    [self addChild:intro2];
    
    CCMenuItemFont* backItem=[CCMenuItemFont itemWithString:@"back" target:self selector:@selector(backTo)];
    [backItem setFontName:@"MarkerFelt-Thin"];
    [backItem setFontSize:35];

    back=[CCMenu menuWithItems:backItem, nil];
    [self addChild:back];

}

-(void)backTo{
    [begin setVisible:YES];
    [starMenu setVisible:YES];
    [player setVisible:YES];
    [gameTitle setVisible:YES];
    
    [self removeChild:about cleanup:YES];
    [self removeChild:intro cleanup:YES];
    [self removeChild:back cleanup:YES];
    [self removeChild:intro2 cleanup:YES];

}

// 载入背景
- (void) loadBackground {
   // BG1 = [CCSprite spriteWithSpriteFrameName:@"background_2.png"];
    BG1=[CCSprite spriteWithFile:@"t3.jpg"];
    printf("*****************\n");
    printf("width:%f height:%f\n",WINDOWWIDTH,WINDOWHEIGHT);
   [BG1 setAnchorPoint:ccp(0.5, 1)];
    
    [BG1 setPosition:ccp(160, adjustmentBG)];
    [self addChild:BG1 z:0];
    BG2=[CCSprite spriteWithFile:@"t3.jpg"];
  //  BG2 = [CCSprite spriteWithSpriteFrameName:@"background_2.png"];
    [BG2 setAnchorPoint:ccp(0.5, 1)];
    [BG2 setPosition:ccp(160, 568+adjustmentBG)];
    [self addChild:BG2 z:0];
    
    scoreLabel=[CCLabelTTF labelWithString:@"0000" fontName:@"MarkerFelt-Thin" fontSize:24];
    [scoreLabel setColor:ccc3(255, 255, 255)];
    scoreLabel.anchorPoint=ccp(0,1);
    scoreLabel.position=ccp(10,WINDOWHEIGHT-10);
    [self addChild:scoreLabel z:4];
    /*
    CCMenuItem* pauseMenuItem=[CCMenuItemImage itemWithNormalImage:@"BurstAircraftPause.png" selectedImage:@"BurstAircraftPause.png" target:self
                               selector:@selector(gamePause)];
    
    [pauseMenuItem setAnchorPoint:ccp(0,1)];
    pauseMenuItem.position=ccp(WINDOWWIDTH-50,WINDOWHEIGHT-20);
    starMenu=[CCMenu menuWithItems:pauseMenuItem,nil];
    starMenu.position=CGPointZero;
    [self addChild:starMenu z:4];
    starMenu.tag=10;
    */
}
#pragma mark -
#pragma mark - 游戏属性 得分 开始 结束等等
- (void) gamePause
{
    if (isGameOver == NO)
    {
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        
        CCMenuItemFont *gameOverItem = [CCMenuItemFont itemFromString:@"START GAME" target:self selector:@selector(gameStart)];
        [gameOverItem setFontName:@"MarkerFelt-Thin"];
        [gameOverItem setFontSize:30];
        CCMenuItemFont *quit=[CCMenuItemFont itemWithString:@"Quit" target:self selector:@selector(quit)];
        [quit setFontName:@"MarkerFelt-Thin"];
        [quit setFontSize:30];
        
        restart = [CCMenu menuWithItems:gameOverItem,quit, nil];
         [restart alignItemsVerticallyWithPadding:30];
        [restart setPosition:ccp(160, WINDOWHEIGHT/2)];
        [self addChild:restart z:4];
        isGameOver = YES;
    }
   /* else
    {
        [prop stopAllActions];
    }*/
}

- (void) gameStart
{
    if (isGameOver == YES)
    {
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        [self removeChild:restart cleanup:YES];
        isGameOver = NO;
    }
}

- (void) initData {
    //adjustmentBG = 568;
    adjustmentBG=700;
    bulletSum = 0;
    isBigBullet = NO;
    isChangeBullet = NO;
    bulletTiming = 900;
    bulletSpeed = 25;
    bigPlan = 0;
    smallPlan = 0;
    mediumPlan = 0;
    props = 0;
    score = 0;
    isVisible = NO;
    isGameOver = NO;
    hd=100;
    foePlanes = [CCArray array];
  }


// 背景滚动
- (void) backgrouneScroll {
     adjustmentBG--;
    
    if (adjustmentBG<=0) {
        adjustmentBG = 568;
    }
    
    [BG1 setPosition:ccp(160, adjustmentBG)];
    [BG2 setPosition:ccp(160, adjustmentBG+568)];
    
}
// 玩家飞机加载
- (void) loadPlayer {
    
   
    
    NSMutableArray *playerActionArray = [NSMutableArray array];
    for (int i = 1 ; i<=2; i++) {
        NSString* key = [NSString stringWithFormat:@"hero_fly_%d.png", i];
        //从内存池中取出Frame
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:key];
        //添加到序列中
        [playerActionArray addObject:frame];
    }
    
    //将数组转化为动画序列,换帧间隔0.1秒
    CCAnimation* animPlayer = [CCAnimation animationWithSpriteFrames:playerActionArray delay:0.1f];
    //生成动画播放的行为对象
    id actPlayer = [CCAnimate actionWithAnimation:animPlayer];
    //清空缓存数组
    [playerActionArray removeAllObjects];
    
    player=[CCSprite spriteWithSpriteFrameName:@"hero_fly_1.png"];
    player.position=ccp(160,50);
    [self addChild:player z:3];
    [player runAction:[CCRepeatForever actionWithAction:actPlayer]];
    
}

// 发射子弹
- (void) firingBullets {
    
    bullet.position=ccp(bullet.position.x,bullet.position.y+bulletSpeed);
  
    if (bullet.position.y>WINDOWHEIGHT-20) {
        [[SimpleAudioEngine sharedEngine]playEffect:@"bullet.mp3"];
        [self resetBullet];
    }
    
}


// 发射子弹
- (void) firingBullets2 {
    
    for (CCFoePlane *foePlane in foePlanes) {
        
        [foePlane.bullet2 setPosition:ccp(foePlane.position.x, foePlane.position.y-50-foePlane.bulletspeed2)];
       
       
           foePlane.bulletspeed2+=2;
        
       if (foePlane.bullet2.position.y<100) {
           foePlane.bullet2.position=ccp(foePlane.position.x, foePlane.position.y-50);
           foePlane.bulletspeed2=foePlane.speed;
          
        }
    }
    
}

// 子弹还原
- (void) resetBullet {
    
    if ((isBigBullet&&isChangeBullet)||(!isBigBullet&&isChangeBullet)) {
        [bullet removeFromParent];
        [self madeBullet];
        isChangeBullet = NO;
      
    }
     // printf("HHHHHHHHHHH\n");
    bulletSpeed = (460-(player.position.y + 50))/15;
    if (bulletSpeed<5)bulletSpeed=5;
    bullet.position=ccp(player.position.x,player.position.y+50);
}

// 制造我方子弹
- (void) madeBullet {
    
    bullet=[CCSprite spriteWithSpriteFrameName:(!isBigBullet)?@"bullet1.png":@"bullet2.png"];
    bullet.anchorPoint=ccp(0.5,0.5);
    [self addChild:bullet];
    
}

// 制造敌人子弹
- (CCSprite*) madeBullet2 {
    
    CCSprite* b=[CCSprite spriteWithSpriteFrameName:@"bullet1.png"];
    b.anchorPoint=ccp(0.5,0.5);
    [self addChild:b];
    return b;
    
}



// --------------飞机移动-----------------------

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
    
}

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGPoint retval = newPos;
    retval.x = player.position.x+newPos.x;
    retval.y = player.position.y+newPos.y;
    
    if (retval.x>=286) {
        retval.x = 286;
    }else if (retval.x<=33) {
        retval.x = 33;
    }
    
    if (retval.y >=WINDOWHEIGHT-50) {
        retval.y = WINDOWHEIGHT-50;
    }else if (retval.y <= 43) {
        retval.y = 43;
    }
    
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {
    if (!isGameOver) {
        player.position = [self boundLayerPos:translation];
    }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

// -------------------------------------------

// 移动敌机
- (void) moveFoePlane {
    for (CCFoePlane *foePlane in foePlanes) {
        [foePlane setPosition:ccp(foePlane.position.x, foePlane.position.y-foePlane.speed)];
        if (foePlane.position.y<(-75)) {
            [foePlanes removeObject:foePlane];
            [foePlane removeFromParent];
        }
    }
}

// 添加飞机
- (void) addFoePlane {
    bigPlan++;
    smallPlan++;
    mediumPlan++;
    if (bigPlan>500) {
        CCFoePlane *foePlane = [self makeBigFoePlane];
        [self addChild:foePlane z:3];
        [foePlanes addObject:foePlane];
        bigPlan = 0;
        foePlane.bulletspeed2=foePlane.speed;
        foePlane.bullet2.position=ccp(foePlane.position.x,foePlane.position.y-50);
        [[SimpleAudioEngine sharedEngine]playEffect:@"enemy2_out.mp3"];
    }
    
    if (mediumPlan>400) {
        CCFoePlane *foePlane = [self makeMediumFoePlane];
        [self addChild:foePlane z:3];
        [foePlanes addObject:foePlane];
        mediumPlan = 0;
        foePlane.bulletspeed2=foePlane.speed;
        foePlane.bullet2.position=ccp(foePlane.position.x,foePlane.position.y-50);
      

        
    }
    
    if (smallPlan>45) {
        CCFoePlane *foePlane = [self makeSmallFoePlane];
        [self addChild:foePlane z:3];
        [foePlanes addObject:foePlane];
        smallPlan = 0;
        foePlane.bulletspeed2=foePlane.speed;
        foePlane.bullet2.position=ccp(foePlane.position.x,foePlane.position.y-50);
       


    }
    
}

// 造大飞机
- (CCFoePlane *) makeBigFoePlane {
    
    NSMutableArray *bigFoePlaneActionArray = [NSMutableArray array];
    for (int i = 1 ; i<=2; i++) {
        NSString* key = [NSString stringWithFormat:@"enemy2_fly_%i.png", i];
        //从内存池中取出Frame
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:key];
        //添加到序列中
        [bigFoePlaneActionArray addObject:frame];
    }
    
    //将数组转化为动画序列,换帧间隔0.1秒
    CCAnimation* animPlayer = [CCAnimation animationWithSpriteFrames:bigFoePlaneActionArray delay:0.1f];
    //生成动画播放的行为对象
    id actPlayer = [CCAnimate actionWithAnimation:animPlayer];
    //清空缓存数组
    [bigFoePlaneActionArray removeAllObjects];
    
    CCFoePlane *bigFoePlane = [CCFoePlane spriteWithSpriteFrameName:@"enemy2_fly_1.png"];
    [bigFoePlane setPosition:ccp((arc4random()%210)+55, 732)];
    [bigFoePlane setPlaneType:2];
    [bigFoePlane setHp:30];
    [bigFoePlane setBullet2:[self madeBullet2]];
    [bigFoePlane runAction:[CCRepeatForever actionWithAction:actPlayer]];
    [bigFoePlane setSpeed:(arc4random()%2)+2];
    
    return bigFoePlane;
}

// 造中飞机
- (CCFoePlane *) makeMediumFoePlane {
    CCFoePlane *mediumFoePlane = [CCFoePlane spriteWithSpriteFrameName:@"enemy3_fly_1.png"];
    [mediumFoePlane setPosition:ccp((arc4random()%268)+23, 732)];
    [mediumFoePlane setPlaneType:3];
    [mediumFoePlane setHp:15];
    [mediumFoePlane setBullet2:[self madeBullet2]];
    [mediumFoePlane setSpeed:(arc4random()%3)+2];
    return mediumFoePlane;
}

// 造小飞机
- (CCFoePlane *) makeSmallFoePlane {
    CCFoePlane *smallFoePlane = [CCFoePlane spriteWithSpriteFrameName:@"enemy1_fly_1.png"];
    [smallFoePlane setPosition:ccp((arc4random()%240)+17, 732)];
     // [smallFoePlane setPosition:ccp((arc4random()%240)+17, 332)];
    [smallFoePlane setPlaneType:1];
    [smallFoePlane setHp:1];
    [smallFoePlane setBullet2:[self madeBullet2]];
    [smallFoePlane setSpeed:(arc4random()%5)+2];
    return smallFoePlane;
}

// 制作道具
- (void) makeProps {
    props++;
    if (props>800) {
        prop = [CCProps node];
        [prop initWithType:(arc4random()%2)+4];
        [self addChild:prop.prop];
        [prop propAnimation];
       
        props = 0;
        isVisible = YES;
    }
    
}

// 子弹持续时间
- (void) bulletTiming {
    if (isBigBullet) {
        printf("bullet is%d\n",bulletTiming);
        if (bulletTiming>0) {
            bulletTiming--;
        }else {
            isBigBullet = NO;
            isChangeBullet = YES;
            bulletTiming = 15;
        }
    }
}

// 碰撞检测
- (void) collisionDetection {
    
    // 子弹跟敌机
    CGRect bulletRec = bullet.boundingBox;
    for (CCFoePlane *foePlane in foePlanes) {
        if (CGRectIntersectsRect(bulletRec, foePlane.boundingBox)) {
             [[SimpleAudioEngine sharedEngine]playEffect:@"bullet.mp3"];
           
            [self resetBullet];
            [self fowPlaneHitAnimation:foePlane];
            foePlane.hp = foePlane.hp-(isBigBullet?2:1);
            if (foePlane.hp<=0) {
                [self fowPlaneBlowupAnimation:foePlane];
                [foePlanes removeObject:foePlane];
            }
            
        }
    }
    
    // 飞机跟打飞机
    CGRect playerRec = player.boundingBox;
   // printf("the x is%f the y is%f the w is%f the h is%f\n",playerRec.origin.x,playerRec.origin.y,playerRec.size.width,playerRec.size.height);
    playerRec.origin.x += 25;
    playerRec.size.width -= 50;
    playerRec.origin.y -= 10;
    playerRec.size.height -= 10;
    for (CCFoePlane *foePlane in foePlanes) {
        if (CGRectIntersectsRect(playerRec, foePlane.boundingBox)) {
            CCProgressTimer* ct=(CCProgressTimer*)[self getChildByTag:90];
            hd=0;
            ct.percentage=0;
            if(hd<=0){
            [self gameOver];
            [self playerBlowupAnimation];
                       }
           
            [self fowPlaneBlowupAnimation:foePlane];
            [foePlanes removeObject:foePlane];
        }
        
        if(CGRectIntersectsRect(playerRec, foePlane.bullet2.boundingBox)){
             CCProgressTimer* ct=(CCProgressTimer*)[self getChildByTag:90];
            foePlane.bullet2.position=ccp(foePlane.position.x, foePlane.position.y-50);
            foePlane.bulletspeed2=foePlane.speed;
            [[SimpleAudioEngine sharedEngine]playEffect:@"bullet.mp3"];
            if(hd>=20&&ct.percentage>=20){
            ct.percentage-=20;
                hd-=20;}
            else{
                ct.percentage=0;
                hd=0;
            
            }
            if(hd<=0){
                [self gameOver];
                [self playerBlowupAnimation];
            }
        
        
        }
    }
    
    // 飞机跟道具
    
    if (isVisible) {
        //printf("hahahahah\n");
        CGRect playerRec1 = player.boundingBox;
        CGRect propRec = prop.prop.boundingBox;
        if (CGRectIntersectsRect(playerRec1, propRec)) {
            
            [prop.prop stopAllActions];
            [prop.prop removeFromParent];
            isVisible = NO;
            
            if (prop.type == propsTypeBullet) {
                isBigBullet = YES;
                isChangeBullet = YES;
            }else if (prop.type == propsTypeBomb) {
                for (CCFoePlane *foePlane in foePlanes) {
                    [self fowPlaneBlowupAnimation:foePlane];
                }
                [foePlanes removeAllObjects];
            }
        }
    }
    
    
}

// 添加打击效果
- (void) fowPlaneHitAnimation:(CCFoePlane *)foePlane {
    if (foePlane.planeType == 3) {
        if (foePlane.hp==13) {
            NSMutableArray *playerActionArray = [NSMutableArray array];
            for (int i = 1 ; i<=2; i++) {
                NSString* key = [NSString stringWithFormat:@"enemy3_hit_%d.png",i];
                //从内存池中取出Frame
                CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:key];
                //添加到序列中
                [playerActionArray addObject:frame];
            }
            
            //将数组转化为动画序列,换帧间隔0.1秒
            CCAnimation* animPlayer = [CCAnimation animationWithSpriteFrames:playerActionArray delay:0.1f];
            //生成动画播放的行为对象
            id actPlayer = [CCAnimate actionWithAnimation:animPlayer];
            //清空缓存数组
            [playerActionArray removeAllObjects];
            [foePlane stopAllActions];
            [foePlane runAction:[CCRepeatForever actionWithAction:actPlayer]];
        }
    }else if (foePlane.planeType == 2) {
        if (foePlane.hp==20) {
            NSMutableArray *playerActionArray = [NSMutableArray array];
            for (int i = 1 ; i<=1; i++) {
                NSString* key = [NSString stringWithFormat:@"enemy2_hit_%d.png",i];
                //从内存池中取出Frame
                CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:key];
                //添加到序列中
                [playerActionArray addObject:frame];
            }
            
            //将数组转化为动画序列,换帧间隔0.1秒
            CCAnimation* animPlayer = [CCAnimation animationWithSpriteFrames:playerActionArray delay:0.1f];
            //生成动画播放的行为对象
            id actPlayer = [CCAnimate actionWithAnimation:animPlayer];
            //清空缓存数组
            [playerActionArray removeAllObjects];
            [foePlane stopAllActions];
            [foePlane runAction:[CCRepeatForever actionWithAction:actPlayer]];
        }
    }
}

// 爆炸动画
- (void) fowPlaneBlowupAnimation:(CCFoePlane *)foePlane {
    int forSum;
    if (foePlane.planeType == 3) {
            [[SimpleAudioEngine sharedEngine]playEffect:@"enemy3_down.mp3"];
        forSum = 4;
        score+=6000;
    }else if (foePlane.planeType  == 2) {
         [[SimpleAudioEngine sharedEngine]playEffect:@"enemy2_down.mp3"];
        score+=30000;
        forSum = 7;
    }else if (foePlane.planeType  == 1) {
         [[SimpleAudioEngine sharedEngine]playEffect:@"enemy1_down.mp3"];
        forSum = 4;
        score+=1000;
    }
    
    [scoreLabel setString:[NSString stringWithFormat:@"%d",score]];
    
    [foePlane stopAllActions];
    NSMutableArray *foePlaneActionArray = [NSMutableArray array];
    
    for (int i = 1; i<=forSum ; i++ ) {
        NSString* key = [NSString stringWithFormat:@"enemy%d_blowup_%i.png",foePlane.planeType , i];
        //从内存池中取出Frame
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:key];
        //添加到序列中
        [foePlaneActionArray addObject:frame];
    }
    
    //将数组转化为动画序列,换帧间隔0.1秒
    CCAnimation* animPlayer = [CCAnimation animationWithSpriteFrames:foePlaneActionArray delay:0.1f];
    //生成动画播放的行为对象
    id actFowPlane = [CCAnimate actionWithAnimation:animPlayer];
    [foePlane.bullet2 removeFromParent];
    id end = [CCCallFuncN actionWithTarget:self selector:@selector(blowupEnd:)];
    //清空缓存数组
    [foePlaneActionArray removeAllObjects];
    
    [foePlane runAction:[CCSequence actions:actFowPlane, end, nil]];
}

// 飞机爆炸
- (void) playerBlowupAnimation {
    NSMutableArray *foePlaneActionArray = [NSMutableArray array];
    
    for (int i = 1; i<=4 ; i++ ) {
        NSString* key = [NSString stringWithFormat:@"hero_blowup_%i.png", i];
        //从内存池中取出Frame
        CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:key];
        //添加到序列中
        [foePlaneActionArray addObject:frame];
    }
    
    //将数组转化为动画序列,换帧间隔0.1秒
    CCAnimation* animPlayer = [CCAnimation animationWithSpriteFrames:foePlaneActionArray delay:0.1f];
    //生成动画播放的行为对象
    id actFowPlane = [CCAnimate actionWithAnimation:animPlayer];
    //清空缓存数组
    [foePlaneActionArray removeAllObjects];
    
    [player runAction:[CCSequence actions:actFowPlane, nil]];
}

- (void) playerBlowupEnd:(id)sender {
    
}

- (void) blowupEnd : (id) sender {
    
    CCFoePlane *foePlane = (CCFoePlane *) sender;
    [foePlane removeFromParent];
    
}

- (void) gameOver {
     [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    isGameOver = YES;
    CCNode *node;
    CCARRAY_FOREACH([self children], node){
        [node stopAllActions];
    }
    
    gameOverLabel = [CCLabelTTF labelWithString:@"GameOver" fontName:@"MarkerFelt-Thin" fontSize:35];
    [gameOverLabel setPosition:ccp(160, 330)];
    [self addChild:gameOverLabel z:4];
    
    CCMenuItemFont *gameOverItem = [CCMenuItemFont itemWithString:@"restart" target:self selector:@selector(restart)];
    [gameOverItem setFontName:@"MarkerFelt-Thin"];
    [gameOverItem setFontSize:30];
    CCMenuItemFont *sharescore=[CCMenuItemFont itemWithString:@"share scores" target:self selector:@selector(shareScore)];
    [sharescore setFontName:@"MarkerFelt-Thin"];
    [sharescore setFontSize:30];
    CCMenuItemFont *quit=[CCMenuItemFont itemWithString:@"Quit" target:self selector:@selector(quit)];
    [quit setFontName:@"MarkerFelt-Thin"];
    [quit setFontSize:30];

    restart = [CCMenu menuWithItems:gameOverItem,sharescore,quit,nil];
     [restart alignItemsVerticallyWithPadding:30];
    [restart setPosition:ccp(160, 200)];
    [self addChild:restart z:4];
    [self snapshotScreen:self];
}


/**游戏截图
 *@param node 需要截取的控件
 */
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


- (void) restart {
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"game_music.mp3"];
    [self removeAllChildren];
    [foePlanes removeAllObjects];
    [self initData];
    [self loadBackground];
    [self loadPlayer];
    [self madeBullet];
    [self resetBullet];
    [self setHdBar];
    
}

-(void)shareScore{
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDirectory=[paths objectAtIndex:0];

     NSString *imagePath=[documentsDirectory stringByAppendingPathComponent:@"saveFore.png"];
    //NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"不要点"
                                                  url:@"http://www.acfun.tv"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
  //  [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
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

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    // in case you have something to dealloc, do it in this method
    // in this particular example nothing needs to be released.
    // cocos2d will automatically release all the children (Label)
    

}


// on "dealloc" you need to release all your retained objects

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
