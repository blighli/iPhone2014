//
//  CardMatchingGame.m
//  cardGame
//
//  Created by 葛云波 on 14/12/1.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, strong) NSMutableArray *cards;//of Card
@property (nonatomic, strong) NSMutableArray *matchArray;

@end

@implementation CardMatchingGame
-(NSMutableArray *)matchArray{
    if(!_matchArray){
        _matchArray = [[NSMutableArray alloc] init];
    }
    return _matchArray;
}
-(NSMutableArray *)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int MISMATCH_PENALTY = 2;

-(void)chooseCardAtIndex:(NSUInteger)index withMatchCount:(NSInteger)matchCount{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.Chosen = NO;
        } else {
            //match against other chosen cards
            for (Card *otherCard in self.cards){
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= matchScore * MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;//can only choose 2 cards
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}



@end
