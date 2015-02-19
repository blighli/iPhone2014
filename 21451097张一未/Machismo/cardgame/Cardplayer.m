//
//  Cardplayer.m
//  cardgame
//
//  Created by emily on 14-10-2.
//  Copyright (c) 2014年 com.emily. All rights reserved.
//

#import "Cardplayer.h"

@implementation Cardplayer
-(void)randromcontents
{
    
    int value = arc4random()%3;
    if(value==0)
    {
        self.contents=@"✌️";
    }
    else if (value==1)
    {
        self.contents=@"👊";
    }
    else
    {
        self.contents=@"👋";
    }
}


@end
