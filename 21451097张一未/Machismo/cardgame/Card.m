//
//  Card.m
//  cardgame
//
//  Created by emily on 14-10-2.
//  Copyright (c) 2014年 com.emily. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards){
        
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}
@end
