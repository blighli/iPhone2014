//
//  Deck.h
//  cardGame
//
//  Created by 葛 云波 on 14/11/29.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
@property (strong, nonatomic)NSMutableArray *cards;//of Card
-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addcard:(Card *)card;

-(Card *)drawRandomCard;

@end
