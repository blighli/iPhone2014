//
//  AddHabitViewController.h
//  iHabit
//
//  Created by 陆钟豪 on 14/12/10.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddHabitViewController : UIViewController

- (IBAction)addHabit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *habitTextField;
@property (weak, nonatomic) IBOutlet UIView *timesPicker;
@property (weak, nonatomic) IBOutlet UIView *periodPicker;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIButton *backButton;

@end


@interface PeriodTimesPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@end