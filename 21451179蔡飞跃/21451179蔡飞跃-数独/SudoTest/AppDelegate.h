//
//  AppDelegate.h
//  SudoTest
//
//  Created by 蔡飞跃 on 14/12/22.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Sudoku.h"

@class FirstViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *g_navController;
}

@property (strong,nonatomic) UIWindow *window;
@property (assign,nonatomic) UINavigationController *g_navController;

@end
