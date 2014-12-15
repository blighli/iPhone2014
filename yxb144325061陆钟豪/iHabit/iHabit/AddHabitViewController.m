//
//  AddHabitViewController.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/10.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "AddHabitViewController.h"
#import "HabitBiz.h"

@interface AddHabitViewController ()

@end

@implementation AddHabitViewController {
    HabitBiz* _habitBiz;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _habitBiz = [HabitBiz getInstance];
    PeriodTimesPickerViewController *periodTimesPickerViewController = [[PeriodTimesPickerViewController alloc] init];
    periodTimesPickerViewController.view = _periodTimesPicker;
    [periodTimesPickerViewController viewDidLoad];
    _periodTimesPicker.dataSource = periodTimesPickerViewController;
    _periodTimesPicker.delegate = periodTimesPickerViewController;
    [self addChildViewController:periodTimesPickerViewController];
    
    self.navigationItem.hidesBackButton = YES;  //隐藏默认back按钮
    UIBarButtonItem * transitionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(gotoMenu:)];
    self.navigationItem.rightBarButtonItem = transitionButton;

    
}

-(IBAction)gotoMenu:(id)sender {
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cube";
    animation.subtype = kCATransitionFromTop;
    [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addHabit:(id)sender {
    [_habitBiz saveHabitWithTitle: self.habitTitleTextField.text
                          iconName: @"start" period:[_periodTimesPicker selectedRowInComponent:0]
                            times: [NSNumber numberWithInteger:[_periodTimesPicker selectedRowInComponent:1] + 1]];
    [self.navigationController popViewControllerAnimated:YES];
}
 

@end

@implementation PeriodTimesPickerViewController
{
    NSArray *_periodTitleArray;
    NSArray *_timesTitleArray;
}

-(void)viewDidLoad {
    _periodTitleArray = [NSArray arrayWithObjects:@"Day", @"Week", @"Month", @"Year", nil];
    _timesTitleArray = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7",nil];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return [_periodTitleArray count];
        case 1:
            return [_timesTitleArray count];
        default:
            return 0;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [_periodTitleArray objectAtIndex:row];
        case 1:
            return [_timesTitleArray objectAtIndex:row];
        default:
            return @"";
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}


@end
