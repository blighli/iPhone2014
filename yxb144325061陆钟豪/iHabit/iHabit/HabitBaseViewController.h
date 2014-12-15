//
//  HabitBaseViewController.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/15.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HabitBaseViewController : UIViewController

@property (strong, nonatomic, readonly) UIViewController *viewController;
@property (weak, nonatomic, readonly) UINavigationBar *navigationBar;
-(instancetype)initWithViewController:(UIViewController*) viewController;

@end
