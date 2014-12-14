//
//  HabitTableCellView.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/3.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Habit.h"
#import "TimeLineView.h"

@interface HabitTableViewCell : UITableViewCell

@property (weak, nonatomic) UIColor *cellColor;
@property (weak, nonatomic) Habit *habit;

@end
