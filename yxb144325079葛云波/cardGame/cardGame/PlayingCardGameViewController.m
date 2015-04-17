//
//  PlayingCardGameViewController.m
//  cardGame
//
//  Created by 葛云波 on 14/12/15.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)creatDeck{
    return [[PlayingCardDeck alloc]init];
}


@end
