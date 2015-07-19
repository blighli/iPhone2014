//
//  HabitTableCellViewController.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/3.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HabitTableViewCell.h"

@interface HabitTableCellViewController : UIViewController

@property CGFloat offsetMinX, offsetMaxX;
@property (weak, nonatomic) TimeLineView *timeLineView;

@end
