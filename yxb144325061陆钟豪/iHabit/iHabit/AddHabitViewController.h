//
//  AddHabitViewController.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/10.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddHabitViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *habitTitleTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *periodTimesPicker;

- (IBAction)addHabit:(id)sender;

@end


@interface PeriodTimesPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@end