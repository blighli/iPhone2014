//
//  EditListViewController.h
//  ToDoList
//
//  Created by 顾准新 on 14-11-9.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainDelegate;

@interface EditListViewController : UIViewController

@property (nonatomic,strong)id<MainDelegate> delegate;
@property (nonatomic,copy)NSString *editText;
@property (nonatomic)NSInteger row;
@end
