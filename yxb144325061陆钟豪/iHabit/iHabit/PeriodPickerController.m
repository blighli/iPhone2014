//
//  PeriodPickerController.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/19.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "PeriodPickerController.h"

@implementation PeriodPickerController

-(void)viewDidLoad {
    [super viewDidLoad];
    NSArray *periodName = @[@"Day", @"Week", @"Month", @"Year"];
    for(NSInteger i = 0; i < [periodName count]; ++i) {
        UIButton *timesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        timesButton.frame = CGRectMake(0, 0, self.view.bounds.size.width / 2 / 4, self.view.bounds.size.height);
        [timesButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [timesButton setTitle:[periodName objectAtIndex:i] forState:UIControlStateNormal];
        timesButton.titleLabel.textColor = UIColor.blackColor;
        timesButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [timesButton addTarget:self action:@selector(selectCellView:) forControlEvents:UIControlEventTouchUpInside];
        [self addCellView:timesButton];
    }
    self.numberOfCellInRow = 6;
    self.horizontalSpace = 0;
    self.verticalSpace = 0;
    [self layoutCellViews];
    [self selectCellViewWithIndex:0];
}

-(HabitPeriod)selectedPeriod {
    return self.selectedCellViewIndex;
}

@end
