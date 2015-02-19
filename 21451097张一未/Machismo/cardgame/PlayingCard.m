//
//  PlayingCard.m
//  cardgame
//
//  Created by emily on 14-10-2.
//  Copyright (c) 2014年 com.emily. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit])
            score = 1;
    }else  if(otherCards.count ==2)
    {
        PlayingCard *firstCard =otherCards[0];
        PlayingCard *secondCard =otherCards[1];
        if([firstCard.suit isEqualToString:self.suit] && [firstCard.suit isEqualToString:secondCard.suit])
        {
            score =1;
        }else if(firstCard.rank ==self.rank && firstCard.rank==secondCard.rank)
        {
            score = 4;
        }
    }

    
    
    return score;
}

-(NSString *)contents
{
    NSArray *rankStrings =[PlayingCard rankstrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit=_suit;

+ (NSArray *)validSuits 
{
    return @[@"♥️",@"♦️",@"♠️",@"♣️"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankstrings
{
    return @[@"?",@"A",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
             @"J",@"Q",@"K"];;
}

+ (NSUInteger)maxRank { return [[self rankstrings] count] - 1;}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
