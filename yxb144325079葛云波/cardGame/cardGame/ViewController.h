//
//  ViewController.h
//  cardGame
//
//  Created by 葛 云波 on 14/11/29.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//Abstract class.Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"
@interface ViewController : UIViewController

-(Deck *)creatDeck;//abstract
@end

