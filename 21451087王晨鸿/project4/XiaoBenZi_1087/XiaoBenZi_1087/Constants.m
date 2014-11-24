//
//  Constants.m
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-23.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@implementation Constants

+(OnePiece*)getPastOnePiece
{
    return pastOnePiece;
}
+(NSInteger)getWhoPastit
{
    return whoPastit;
}
+(void)setPastOnePiece:(OnePiece*)onePiece
{
    pastOnePiece = onePiece;
}
+(void)setWhoPastit:(NSInteger)who
{
    whoPastit = who;
}
@end