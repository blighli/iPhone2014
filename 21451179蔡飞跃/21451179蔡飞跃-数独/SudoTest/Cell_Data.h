//
//  Cell_Data.h
//  SudoTest
//
//  Created by 蔡飞跃 on 14/12/22.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface Cell_Data : NSObject

{
    int x;
    int y;
    int value;
    BOOL isBlank;
    NSMutableArray *validList;
}

@property (assign,readwrite)int x;
@property (assign,readwrite)int y;
@property (assign,readwrite)int value;
@property (assign,readwrite)BOOL isBlank;
@property (assign,readwrite)NSMutableArray *validList;

-(id)initWithX:(int)fx Y:(int)fy;

@end
