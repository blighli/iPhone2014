//
//  Card.h
//  cardgame
//
//  Created by emily on 14-10-2.
//  Copyright (c) 2014年 com.emily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;

@property (nonatomic,getter = isChosen) BOOL chosen;
@property (nonatomic,getter = isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;

@end
