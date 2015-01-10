//
//  PlayingCard.m
//  cardGame
//
//  Created by 葛 云波 on 14/11/29.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards{
    int score = 0;
    if ([otherCards count] == 1) {
        id card = [otherCards firstObject];
        if ([card isKindOfClass:[PlayingCard class]]){
            PlayingCard *otherCard = (PlayingCard *) card;
            if (otherCard.rank == self.rank ) {
                score = 4;
            } else if ([otherCard.suit isEqualToString:self.suit]){
                score = 1;
            }
        }
    }
    return score;
}

-(NSString *)contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;//because we provide setter and getter

+(NSArray *)validSuits{
    return @[@"♥️",@"♦️",@"♠️",@"♣️"];
}

-(void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit{
    return _suit ? _suit : @"?";//如果suit是nil则返回“？”，否则返回实际值
}

+(NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank{
    return [[self rankStrings] count]-1;
}

-(void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
