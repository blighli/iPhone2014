//
//  TimesPickerController.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/19.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "TimesPickerController.h"

@implementation TimesPickerController

-(void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"self.view.bounds.size.width:%f", self.view.bounds.size.width);
    for(NSInteger i = 1; i <= 6; ++i) {
        UIButton *timesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        timesButton.frame = CGRectMake(0, 0, self.view.bounds.size.width / 2 / 6, self.view.bounds.size.height); // FIXME timesButton.frame = CGRectMake(0, 0, self.view.bounds.size.width / 6, self.view.bounds.size.height);
        [timesButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [timesButton setTitle:[NSString stringWithFormat:@"%ld", i] forState:UIControlStateNormal];
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

-(NSInteger)selectedTimes {
    NSInteger selectedCellViewIndex = self.selectedCellViewIndex;
    return selectedCellViewIndex + 1;
}

@end
