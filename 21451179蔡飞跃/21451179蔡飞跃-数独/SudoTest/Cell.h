//
//  Cell.h
//  SudoTest
//
//  Created by 蔡飞跃 on 14/12/22.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface Cell : UIButton
{
    BOOL isBlank;//YES：需要用户输入的 NO：提供给用户的
    int x;//宫格的坐标
    int y;
    int value;//最终要验证的值
    int userValue;//用户输入的值
    NSMutableArray *noteList;
}

@property(assign) BOOL isBlank;
@property(assign) int x;
@property(assign) int y;
@property(assign) int value;
@property(assign) int userValue;
@property(nonatomic,copy) NSMutableArray *noteList;

@end
