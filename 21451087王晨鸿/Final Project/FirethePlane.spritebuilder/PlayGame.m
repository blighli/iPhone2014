//
//  PlayGame.m
//  FirethePlane
//
//  Created by qtsh on 14/12/13.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayGame.h"
#import "Enemy3.h"
#import "Enemy2.h"
#import "Bomb.h"
#import "BombPng.h"

@implementation PlayGame
{
    CCNode * Layer;
    CCPhysicsNode* pn_hero;
    CCSprite * hero;
    NSMutableArray * bullets;
CCPhysicsNode *_physicsNode;
    CCSprite * bombPng;

    int No;
    CCNode * _background;
    CCLabelTTF * _score;
    CCLabelTTF * _bombCount;
    int score;
    int isdead;
    CGPoint  tempPoint;
    int dieCount;
    int pause;
    int DIE_TIMES;
    int bombCount;
    int catch;
    int DELETE_BOMB_DELAY_TIME;
}
-(void)pause
{NSLog(@"pause");
    
    pause ++;
    pause = pause%2;
    if (pause == 0) {
        [[CCDirector sharedDirector] resume];
    }
    else
    {
        [[CCDirector sharedDirector] pause];
        CCNode * replay = [CCBReader load:@""];
    }
};
-(void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    [self setUserInteractionEnabled:true];
    [_physicsNode setCollisionDelegate:self];
    score = 0;
    isdead = 0;
    dieCount = 0;
    pause = 0;
    DIE_TIMES = 2;
    bombCount = 0;
    
    DELETE_BOMB_DELAY_TIME = 3;
    hero = [CCBReader load:@"hero"];
    hero.position = ccp(160, 50);
    [_physicsNode addChild:hero];
    //hero.physicsBody.collisionType=@"hero";
    bombPng = [CCBReader load:@"BombPng"];
    bombPng.position = ccp(50,50);
    [_physicsNode addChild:bombPng];
    NSMutableString * temp = [NSMutableString stringWithFormat:@"%d",bombCount];
    //[((BombPng *)bombPng).bombPngCount setString:temp];
    
    [self schedule:@selector(addBullets) interval:0.2f];
    [self schedule:@selector(addEnemy1) interval:0.5f];
    [self schedule:@selector(addEnemy3) interval:8.0f];
    [self schedule:@selector(addEnemy2) interval:30.0f];
    [self schedule:@selector(addBomb) interval:50.0f];
    
}
-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint location =[touch locationInWorld];
    hero.position = location;
}
-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    NSLog(@"touched");
    if (bombCount >0) {
    CGPoint location =[touch locationInWorld];
    CGFloat x = location.x;
    CGFloat y = location.y;
    
    if( x>=25 && x<= 75 && y>=25 && y<=75)
    {
        bombCount --;
        [_bombCount setString:[NSString stringWithFormat:@"%d",bombCount]];
        NSLog(@"BOOM!");
        //大爆炸
        @try {
            int ct = _physicsNode.children.count;
            for (int i = ct-1; i>= 0 ; i-- ) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
                if ( [bs.name isEqualToString:@"bullet"] == YES ) {
                    
                    [_physicsNode removeChild:bs cleanup:YES];
                }
                if ( [bs.name isEqualToString:@"enemy1"] == YES ) {
                    CCSprite * Enemy1Die = [CCBReader load:@"Enemy1Die"];
                    Enemy1Die.position = bs.position;
                    [_physicsNode addChild:Enemy1Die];
                    [_physicsNode removeChild:bs cleanup:YES];
                    score += 1000;
                }
                if ( [bs.name isEqualToString:@"enemy2"] == YES ) {
                    CCSprite * Enemy2Die = [CCBReader load:@"Enemy2Die"];
                    Enemy2Die.position = bs.position;
                    [_physicsNode addChild:Enemy2Die];
                    [_physicsNode removeChild:bs cleanup:YES];
                    score += 10000;
                }
                if ( [bs.name isEqualToString:@"enemy3"] == YES ) {
                    CCSprite * Enemy3Die = [CCBReader load:@"Enemy3Die"];
                    Enemy3Die.position = bs.position;
                    [_physicsNode addChild:Enemy3Die];
                    [_physicsNode removeChild:bs cleanup:YES];
                    score += 30000;
                }
            }
            [_score setString:[NSString stringWithFormat:@"%d",score]];
        }
        @catch (NSException *exception) {
            NSLog(@"Boom exception");
        }
        @finally {
            
        }
        
    }
    }
}
-(void)addBullets
{
    
    if(isdead == 0)
    {
    NSLog(@"add bullet");
    CCNode* bullet = [CCBReader load:@"Bullet1"];
    // position the penguin at the bowl of the catapult
    //bullet.position = hero.position;
    bullet.position = ccpAdd(hero.position, ccp(0,50)  );
    bullet.name = @"bullet";
    // add the penguin to the physicsNode of this scene (because it has physics enabled)
    //[_physicsNode addChild: bullet z:0];
    [_physicsNode addChild:bullet z:2 name:@"bullet"];

    // manually create & apply a force to launch the penguin
    CGPoint launchDirection = ccp(0, 1);
    CGPoint force = ccpMult(launchDirection, 8000);
    [bullet.physicsBody applyForce:force];
    }
    
    int count = 0;
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"bullet"] == YES ) {
            count ++;
        }
    }
    if( count >50)
    {
        for ( int i = 0; i<25; i++) {
            for (int j =0 ; j<_physicsNode.children.count; j++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                if ( [bs.name isEqualToString:@"bullet"] == YES ) {
                    NSLog(@"to clean bullet");
                    [_physicsNode removeChild:bs cleanup:YES];
                    break;
                }

            }
        }
    }
    
    
    
}
-(void)addEnemy1
{
    NSLog(@"add enemy1");
    CCNode* enemy1 = [CCBReader load:@"Enemy1"];
    int x = arc4random()%280+20;
    enemy1.position = ccp(x, 568 );
    enemy1.name =@"enemy1";

    [_physicsNode addChild:enemy1 z:0 name:@"enemy1"];
    
    
    int speed = arc4random()%3000+7000;
    // manually create & apply a force to launch the penguin
    CGPoint launchDirection = ccp(0, -1);
    CGPoint force = ccpMult(launchDirection, speed);
    [enemy1.physicsBody applyForce:force];
    
    
    //删除多余对象
    int count = 0;
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"enemy1"] == YES ) {
            count ++;
        }
    }
    if( count >50)
    {
        for ( int i = 0; i<15; i++) {
            for (int j =0 ; j<_physicsNode.children.count; j++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                if ( [bs.name isEqualToString:@"enemy1"] == YES ) {
                    NSLog(@"to clean enemy1");
                    [_physicsNode removeChild:bs cleanup:YES];
                    break;
                }
                
            }
        }
    }


}
-(void)addEnemy2
{
    NSLog(@"add enemy2");
    CCNode* enemy2 = [CCBReader load:@"Enemy2"];
    int x = arc4random()%280+20;
    enemy2.position = ccp(x, 600 );
    enemy2.name =@"enemy2";
    
    [_physicsNode addChild:enemy2 z:0 name:@"enemy2"];
    
    
    int speed = arc4random()%3000+5000;
    CGPoint launchDirection = ccp(0, -1);
    CGPoint force = ccpMult(launchDirection, 10000);
    [enemy2.physicsBody applyForce:force];
    
    
    //删除多余对象
    int count = 0;
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"enemy2"] == YES ) {
            count ++;
        }
    }
    if( count >50)
    {
        for ( int i = 0; i<15; i++) {
            for (int j =0 ; j<_physicsNode.children.count; j++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                if ( [bs.name isEqualToString:@"enemy2"] == YES ) {
                    NSLog(@"to clean enemy2");
                    [_physicsNode removeChild:bs cleanup:YES];
                    break;
                }
                
            }
        }
    }
    
    
}
-(void)addEnemy3
{
    NSLog(@"add enemy3");
    CCNode* enemy3 = [CCBReader load:@"Enemy3"];
    int x = arc4random()%280+20;
    enemy3.position = ccp(x, 568 );
    enemy3.name =@"enemy3";
    
    [_physicsNode addChild:enemy3 z:1 name:@"enemy3"];
    
    
    int speed = arc4random()%3000+5000;
    // manually create & apply a force to launch the penguin
    CGPoint launchDirection = ccp(0, -1);
    CGPoint force = ccpMult(launchDirection, speed);
    [enemy3.physicsBody applyForce:force];
    
    
    //删除多余对象
    int count = 0;
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"enemy3"] == YES ) {
            count ++;
        }
    }
    if( count >50)
    {
        for ( int i = 0; i<15; i++) {
            for (int j =0 ; j<_physicsNode.children.count; j++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                if ( [bs.name isEqualToString:@"enemy3"] == YES ) {
                    NSLog(@"to clean enemy3");
                    [_physicsNode removeChild:bs cleanup:YES];
                    break;
                }
                
            }
        }
    }

}
-(void)addBomb
{
    catch = 0;
    NSLog(@"add Bomb");
    CCNode* bomb = [CCBReader load:@"Bomb"];
    int x = arc4random()%280+20;
    //int x = 120;
    bomb.position = ccp(x, 568 );
    
    [_physicsNode addChild:bomb z:1 ];
    
    [self performSelector:@selector(deleteBomb) withObject:nil afterDelay:DELETE_BOMB_DELAY_TIME];
    
    //删除多余对象
    int count = 0;
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"Bomb"] == YES ) {
            count ++;
        }
    }
    if( count >10)
    {
        for ( int i = 0; i<5; i++) {
            for (int j =0 ; j<_physicsNode.children.count; j++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                if ( [bs.name isEqualToString:@"Bomb"] == YES ) {
                    NSLog(@"to clean Bomb");
                    [_physicsNode removeChild:bs cleanup:YES];
                    break;
                }
                
            }
        }
    }

}
-(void)deleteBomb
{
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"Bomb"] == YES ) {
            [bs removeFromParent];
            NSLog(@"Remove Bomb");
        }
    }
}
-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Bullet1:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    NSLog(@"something hit Bullet1");
    [_physicsNode removeChild:nodeA cleanup:YES];
}
-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Enemy1:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    NSLog(@"something hit Enemy1");
    if ([nodeB.name isEqualToString:@"hero"] == YES) {
        NSLog(@"bullet hit enemy1");
        score += 1000;
        NSMutableString * temp = [NSMutableString stringWithFormat:@"%d",score];
        [_score setString:temp];
        
        CCSprite * Enemy1Die = [CCBReader load:@"Enemy1Die"];
        Enemy1Die.position = nodeA.position;
        [_physicsNode addChild:Enemy1Die];
        [_physicsNode removeChild:nodeA cleanup:YES];
        
        //删除多余对象
        @try{
            int count = 0;
            for (int i = 0; i<_physicsNode.children.count; i++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
                if ( [bs.name isEqualToString:@"Enemy1Die"] == YES ) {
                    count ++;
                }
            }
            if( count >20)
            {
                for ( int i = 0; i<10; i++) {
                    for (int j =0 ; j<_physicsNode.children.count; j++) {
                        CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                        if ( [bs.name isEqualToString:@"Enemy1Die"] == YES ) {
                            NSLog(@"to clean Enemy1Die");
                            [_physicsNode removeChild:bs cleanup:YES];
                            break;
                        }
                        
                    }
                }
            }
        }
        @catch(NSException * ex)
        {
            NSLog(@"Exception Enemy1Die");
            
        }

    }
    
}
-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Enemy2:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    NSLog(@"something hit Enemy2");
    if ([nodeB.name isEqualToString:@"hero"] == YES) {
        NSLog(@"bullet hit enemy2");
        score += 30000;
        NSMutableString * temp = [NSMutableString stringWithFormat:@"%d",score];
        [_score setString:temp];
        
        CCSprite * Enemy2Die = [CCBReader load:@"Enemy2Die"];
        Enemy2Die.position = nodeA.position;
        [_physicsNode addChild:Enemy2Die];
        [_physicsNode removeChild:nodeA cleanup:YES];
        
        //删除多余对象
        @try{
            int count = 0;
            for (int i = 0; i<_physicsNode.children.count; i++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
                if ( [bs.name isEqualToString:@"Enemy2Die"] == YES ) {
                    count ++;
                }
            }
            if( count >20)
            {
                for ( int i = 0; i<10; i++) {
                    for (int j =0 ; j<_physicsNode.children.count; j++) {
                        CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                        if ( [bs.name isEqualToString:@"Enemy1Die"] == YES ) {
                            NSLog(@"to clean Enemy1Die");
                            [_physicsNode removeChild:bs cleanup:YES];
                            break;
                        }
                        
                    }
                }
            }
        }
        @catch(NSException * ex)
        {
            NSLog(@"Exception Enemy1Die");
            
        }
        
    }

}
-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Enemy3:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    NSLog(@"something hit Enemy3");
    if ([nodeB.name isEqualToString:@"hero"] == YES) {
        NSLog(@"hero hit enemy3");
        score += 10000;
        NSMutableString * temp = [NSMutableString stringWithFormat:@"%d",score];
        [_score setString:temp];
        
        CCSprite * Enemy3Die = [CCBReader load:@"Enemy3Die"];
        Enemy3Die.position = nodeA.position;
        [_physicsNode addChild:Enemy3Die];
        [_physicsNode removeChild:nodeA cleanup:YES];
        
        //删除多余对象
        @try{
            int count = 0;
            for (int i = 0; i<_physicsNode.children.count; i++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
                if ( [bs.name isEqualToString:@"Enemy3Die"] == YES ) {
                    count ++;
                }
            }
            if( count >20)
            {
                for ( int i = 0; i<10; i++) {
                    for (int j =0 ; j<_physicsNode.children.count; j++) {
                        CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                        if ( [bs.name isEqualToString:@"Enemy3Die"] == YES ) {
                            NSLog(@"to clean Enemy3Die");
                            [_physicsNode removeChild:bs cleanup:YES];
                            break;
                        }
                        
                    }
                }
            }
        }
        @catch(NSException * ex)
        {
            NSLog(@"Exception Enemy3Die");
            
        }
        
    }

}
-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Enemy2:(CCNode *)nodeA Bullet1:(CCNode *)nodeB
{
    NSLog(@"bullet hit enemy2");
    
    Enemy2* t = (Enemy2*)nodeA;
    t.hitCount = t.hitCount +1;
    NSLog(@"hitCount:%d",t.hitCount);
    
    if( t.hitCount>=12)
    {

    score += 30000;
    NSMutableString * temp = [NSMutableString stringWithFormat:@"%d",score];
    [_score setString:temp];
    
    CCSprite * Enemy2Die = [CCBReader load:@"Enemy2Die"];
    Enemy2Die.position = nodeA.position;
    [_physicsNode addChild:Enemy2Die];
    [_physicsNode removeChild:nodeA cleanup:YES];
    }
    
    //删除多余对象
    @try{
    int count = 0;
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"Enemy2Die"] == YES ) {
            count ++;
        }
    }
    if( count >20)
    {
        for ( int i = 0; i<10; i++) {
            for (int j =0 ; j<_physicsNode.children.count; j++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                if ( [bs.name isEqualToString:@"Enemy2Die"] == YES ) {
                    NSLog(@"to clean Enemy2Die");
                    [_physicsNode removeChild:bs cleanup:YES];
                    break;
                }
                
            }
        }
    }
    }
    @catch(NSException * ex)
    {
        NSLog(@"Exception Enemy2Die");

    }

}
-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Enemy1:(CCNode *)nodeA Bullet1:(CCNode *)nodeB
{
    NSLog(@"bullet hit enemy1");
    score += 1000;
    NSMutableString * temp = [NSMutableString stringWithFormat:@"%d",score];
    [_score setString:temp];
    
    CCSprite * Enemy1Die = [CCBReader load:@"Enemy1Die"];
    Enemy1Die.position = nodeA.position;
    [_physicsNode addChild:Enemy1Die];
    [_physicsNode removeChild:nodeA cleanup:YES];
    
    //删除多余对象
    @try{
    int count = 0;
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"Enemy1Die"] == YES ) {
            count ++;
        }
    }
    if( count >20)
    {
        for ( int i = 0; i<10; i++) {
            for (int j =0 ; j<_physicsNode.children.count; j++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                if ( [bs.name isEqualToString:@"Enemy1Die"] == YES ) {
                    NSLog(@"to clean Enemy1Die");
                    [_physicsNode removeChild:bs cleanup:YES];
                    break;
                }
                
            }
        }
    }
    }
    @catch(NSException * ex)
    {
        NSLog(@"Exception Enemy1Die");

    }

}
-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Enemy3:(CCNode *)nodeA Bullet1:(CCNode *)nodeB
{
    NSLog(@"bullet hit enemy3");
    Enemy3* t = (Enemy3*)nodeA;
    t.hitCount = t.hitCount +1;
    NSLog(@"hitCount:%d",t.hitCount);
    
    if( t.hitCount>=4)
    {
    score += 10000;
    NSMutableString * temp = [NSMutableString stringWithFormat:@"%d",score];
    [_score setString:temp];
    
    CCSprite * Enemy3Die = [CCBReader load:@"Enemy3Die"];
    Enemy3Die.position = nodeA.position;
    [_physicsNode addChild:Enemy3Die];
    [_physicsNode removeChild:nodeA cleanup:YES];
      
        
    }
    
    //删除多余对象
    @try{
    int count = 0;
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"Enemy3Die"] == YES ) {
            count ++;
        }
    }
    if( count >20)
    {
        for ( int i = 0; i<10; i++) {
            for (int j =0 ; j<_physicsNode.children.count; j++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                if ( [bs.name isEqualToString:@"Enemy3Die"] == YES ) {
                    NSLog(@"to clean Enemy3Die");
                    [_physicsNode removeChild:bs cleanup:YES];
                    break;
                }
                
            }
        }
    }
    }
    @catch(NSException *ex)
    {
        NSLog(@"Exception Enemy3Die");
    }

}


-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair hero:(CCNode *)nodeA wildcard:(CCNode *)nodeB
{
    NSLog(@"something hit hero");
    
    if( [ nodeB.name isEqualToString:@"bullet"]  == NO)
    {
        CCSprite * HeroDie = [CCBReader load:@"HeroDie"];
        HeroDie.position = nodeA.position;
        [_physicsNode addChild:HeroDie];
        [_physicsNode removeChild:nodeA cleanup:YES];
        tempPoint = HeroDie.position;
        isdead = 1;
        dieCount ++;
        if (dieCount <= DIE_TIMES) {
            [self performSelector:@selector(loadTimeline) withObject:nil afterDelay:1.5];
        }
        else
        {
            CCNode * gameover= [CCBReader load:@"GameOver"];
            gameover.position = ccp(160, 269);
            [_physicsNode addChild:gameover z:5];
        }

            }
    
    //删除多余对象
    @try{
    int count = 0;
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"HeroDie"] == YES ) {
            count ++;
        }
    }
    if( count >20)
    {
        for ( int i = 0; i<10; i++) {
            for (int j =0 ; j<_physicsNode.children.count; j++) {
                CCSprite * bs = [[_physicsNode children] objectAtIndex:j];
                if ( [bs.name isEqualToString:@"HeroDie"] == YES ) {
                    NSLog(@"to clean HeroDie");
                    [_physicsNode removeChild:bs cleanup:YES];
                    break;
                }
                
            }
        }
    }
    }
    @catch(NSException *ex)
    {
        NSLog(@"Exception HeroDie");

    }

}
-(void)loadTimeline
{
    hero = [CCBReader load:@"hero"];
    hero.position = tempPoint;
    hero.physicsBody.collisionType =@"hero";
    [_physicsNode addChild:hero];
    isdead = 0;

}

-(void)update:(CCTime)delta
{
    //检测炸弹是否和英雄重叠
    for (int i = 0; i<_physicsNode.children.count; i++) {
        CCSprite * bs = [[_physicsNode children] objectAtIndex:i];
        if ( [bs.name isEqualToString:@"Bomb"] == YES ) {//find Bomb
            NSLog(@"bomb posY:%f,posX:%f , child bomb posY:%f posX:%f ,  hero posY:%f posX:%f",bs.position.y,bs.position.x,[bs convertToWorldSpace:((Bomb*)bs).bomb.position].y,[bs convertToWorldSpace:((Bomb*)bs).bomb.position].x, hero.position.y,hero.position.x);
            CGFloat bombX = [bs convertToWorldSpace:((Bomb*)bs).bomb.position].x;
            CGFloat bombY = [bs convertToWorldSpace:((Bomb*)bs).bomb.position].x;
            CGFloat heroX = hero.position.x;
            CGFloat heroY = hero.position.y;
            CGFloat deltX = abs(bombX - heroX);
            CGFloat deltY = abs(bombY - heroY);
            NSLog(@"deltX:%f, deltY:%f", deltX , deltY);
            CGRect hRect = CGRectMake(heroX, heroY, hero.boundingBox.size.width, hero.boundingBox.size.height);
            CGRect bRect = CGRectMake(bombX, bombY, ((Bomb*)bs).bomb.boundingBox.size.width,((Bomb*)bs).bomb.boundingBox.size.height );
            if ( deltX <25 && deltY <70 && catch ==0 ) {
                //增加Bomb图标
                bombCount ++;
                NSMutableString * temp = [NSMutableString stringWithFormat:@"%d",bombCount];
                [_bombCount setString:temp ];
                NSLog(@"catch bomb");
                //消除bomb
                [_physicsNode removeChild:bs cleanup:YES];
                break;
            }
        }
    }
}
@end