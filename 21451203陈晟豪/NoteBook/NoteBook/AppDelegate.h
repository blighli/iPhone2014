//
//  AppDelegate.h
//  NoteBook
//
//  Created by 陈晟豪 on 14/11/21.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property NSMutableArray *contentArray;
@property NSMutableArray *numberArray;
@property NSMutableArray *titleArray;
@property sqlite3 *database;
@property NSInteger databaseIndexPath;
@property (strong, nonatomic) UIWindow *window;

@end

