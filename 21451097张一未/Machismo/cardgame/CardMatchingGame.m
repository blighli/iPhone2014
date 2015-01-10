//
//  CardMatchingGame.m
//  cardgame
//
//  Created by emily on 14-10-2.
//  Copyright (c) 2014年 com.emily. All rights reserved.
//

#import "CardMatchingGame.h"
#import "cardgameViewController.h"


@interface CardMatchingGame()
@property(nonatomic,readwrite) NSInteger score;
@property(nonatomic,strong) NSMutableArray *cards;

@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards=[[NSMutableArray alloc] init];
    }
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else{
                self = nil;
                break;
            }
            
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int MISMATCH_PENALTY3 = 2;
static const int MATCH_BONUS3 = 5;
static const int COST_TO_CHOOSE3 = 1;


-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else{
            Card *firstCard=nil;
            Card *secondCard=nil;
            switch (flagcard) {
                case 0:
                    for(Card *otherCard in self.cards){
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            int matchScore = [card match:@[otherCard]];
                            if (matchScore) {
                                self.score += matchScore * MATCH_BONUS;
                                otherCard.matched = YES;
                                card.matched = YES;
                            } else{
                                self.score -= MISMATCH_PENALTY;
                                otherCard.chosen = NO;
                            }
                            break;
                        }
                    }
                    self.score -= COST_TO_CHOOSE;
                    card.chosen = YES;
                    break;
                
                case 1:
                    for (Card *otherCard in self.cards) {
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            if (!firstCard) {
                                firstCard = otherCard;
                                }
                            if (firstCard != otherCard) {
                                secondCard = otherCard;
                            }
                            if (secondCard) {
                                int matchScore = [card match:@[firstCard,secondCard]];
                                if (matchScore>0) {
                                    firstCard.matched=YES;
                                    secondCard.matched=YES;
                                    card.matched=YES;
                                    self.score+=matchScore * MATCH_BONUS3;
                                    
                                }
                                else
                                {
                                    firstCard.chosen = NO;
                                    secondCard.chosen = NO;
                                    self.score -= matchScore * MISMATCH_PENALTY3;
                                    
                                }
                                break;
                            }
                        }
                        
                    }
                    self.score -= COST_TO_CHOOSE3;
                    card.chosen = YES;
                    break;
                    break;
                default:
                    break;
            }
        }
    }
}

@end
