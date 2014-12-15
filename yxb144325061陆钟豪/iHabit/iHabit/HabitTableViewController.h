//
//  HabitTableViewController.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/3.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Habit.h"
#import "HabitBaseViewController.h"

@interface HabitTableViewController : UITableViewController <UIScrollViewDelegate>

+(HabitBaseViewController*) createHabitViewController;
@property (weak, nonatomic) HabitBaseViewController* habitBaseViewController;

@end

