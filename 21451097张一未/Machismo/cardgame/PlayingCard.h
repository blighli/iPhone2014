//
//  PlayingCard.h
//  cardgame
//
//  Created by emily on 14-10-2.
//  Copyright (c) 2014年 com.emily. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
