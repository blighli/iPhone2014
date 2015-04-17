//
//  Card.m
//  cardGame
//
//  Created by 葛 云波 on 14/11/29.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card
//if match return 1, otherwise return 0
-(int) match:(NSArray *)otherCards{
    int score = 0;
    for (Card *card in otherCards){
        if ([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    
    return score;
}


@end
