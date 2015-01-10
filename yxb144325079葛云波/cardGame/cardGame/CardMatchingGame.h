//
//  CardMatchingGame.h
//  cardGame
//
//  Created by 葛云波 on 14/12/1.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index withMatchCount:(NSInteger)matchCount;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic) NSInteger score;

@end
