//
//  PeriodPickerController.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/19.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridPickerViewController.h"
#import "Habit.h"

@interface PeriodPickerController : GridPickerViewController

@property (readonly) HabitPeriod selectedPeriod;

@end
