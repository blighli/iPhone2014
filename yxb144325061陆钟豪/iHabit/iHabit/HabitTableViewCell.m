//
//  HabitTableCellView.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/3.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "HabitTableViewCell.h"
#import "TimeLineView.h"

@implementation HabitTableViewCell

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15, 24, 32, 32);
    self.textLabel.frame = CGRectMake(63.5, 22, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    self.textLabel.backgroundColor = UIColor.clearColor;
}

-(void)setHabit:(Habit *)habit {
    
    self.textLabel.text = habit.title;
    self.imageView.image = [UIImage imageNamed:@"start"];
    _habit = habit;
}

-(Habit *)Habit {
    return _habit;
}



@end
