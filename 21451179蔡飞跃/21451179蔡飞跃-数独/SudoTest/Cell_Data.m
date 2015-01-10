//
//  Cell_Data.m
//  SudoTest
//
//  Created by 蔡飞跃 on 14/12/22.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//


#import "Cell_Data.h"

#define random(x) (rand()%x+1)

@implementation Cell_Data

@synthesize x;
@synthesize y;
@synthesize value;
@synthesize isBlank;
@synthesize validList;


-(id)initWithX:(int)fx Y:(int)fy 
{
    if (self = [super init]) {
        x = fx;
        y = fy;
        value = 0;
        isBlank = NO;
        validList = [NSMutableArray arrayWithCapacity:9];
        
        return  self;
    }
    else 
    {
        return nil;
    }
}

-(NSString*)description
{
    NSString *des = [NSString stringWithFormat:@"[%d][%d],%d",x,y,value];
    return des;
}

-(void)dealloc
{
    [super dealloc];
}

@end

