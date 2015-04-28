//
//  GameOver.m
//  FirethePlane
//
//  Created by qtsh on 14/12/16.
//  Copyright (c) 2014年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameOver.h"

@implementation GameOver

-(void)gameover_click
{
    NSLog(@"Game Over");
    CCScene *scene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

@end