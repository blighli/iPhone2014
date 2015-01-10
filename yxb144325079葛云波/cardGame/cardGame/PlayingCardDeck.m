//
//  PlayingCardDeck.m
//  cardGame
//
//  Created by 葛 云波 on 14/11/29.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardDeck()

@end

@implementation PlayingCardDeck

-(instancetype)init{
    self = [super init];
    if(self){
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank=1;rank <= [PlayingCard maxRank];rank++){
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addcard:card];
            }
        }
    }
    return self;
}

@end
