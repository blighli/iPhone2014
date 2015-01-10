//
//  Sudoku.h
//  SudoTest
//
//  Created by 蔡飞跃 on 14/12/22.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//


#import <Foundation/Foundation.h>
@class Cell_Data;

@interface Sudoku : NSObject
{
    Cell_Data *cells[9][9];
}

-(BOOL)isBlankCellWithX:(int)x Y:(int)y;
-(int)GetCellWithX:(int)x Y:(int)y;

-(void)ShowCells;
-(void)createMatrix;
-(void)FillBlankInMatrixWithLevel:(int)level;

-(bool)IsXYvalidWithCell:(Cell_Data *)c N:(int)n;
-(void)InitValidlistforCellX:(int)x Y:(int)y;
-(int)FillCellX:(int)x Y:(int)y;

@end
