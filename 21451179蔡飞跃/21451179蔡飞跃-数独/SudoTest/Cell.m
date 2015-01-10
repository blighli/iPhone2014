//
//  Cell.m
//  SudoTest
//
//  Created by 蔡飞跃 on 14/12/22.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//


#import "Cell.h"

@implementation Cell

@synthesize isBlank;
@synthesize x;
@synthesize y;
@synthesize value;
@synthesize userValue;
@synthesize noteList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isBlank = YES;
        x = 0;
        y = 0;
        value = 0;
        userValue = 0;
        noteList = nil;         
        [self setTitle:@"数字" forState:UIControlStateNormal];
        noteList = [[NSMutableArray alloc]initWithCapacity:9];
    }
    return self;
}

-(void)dealloc
{
    [noteList release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
