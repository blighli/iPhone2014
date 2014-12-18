//
//  AddHabitViewController.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/10.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "AddHabitViewController.h"
#import "HabitBiz.h"
#import "LineView.h"
#import "GridPickerViewController.h"

@interface AddHabitViewController ()

@end

@implementation AddHabitViewController {
    HabitBiz* _habitBiz;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    navigationBarView.backgroundColor = UIColor.whiteColor;
    
    // 添加nav阴影
    navigationBarView.layer.shadowColor = [UIColor blackColor].CGColor;
    navigationBarView.layer.shadowOffset = CGSizeMake(0, 0);
    navigationBarView.layer.shadowOpacity = 0.5;
    navigationBarView.layer.shadowRadius = 5;
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 60)];
    titleLable.font = [UIFont fontWithName:@"Raleway-MediumTracked" size:40];
    titleLable.text = @"New Habit";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(240, 40, 60, 30);
    backButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    backButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Tracked" size:16];
    backButton.tintColor = UIColor.blackColor;
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    UIView *underLineView = [[LineView alloc] initWithFrame:CGRectMake(5, 25, 50, 2)];
    [backButton addSubview:underLineView];
    
    // 绘制按钮背景
    UIImage *selectedBackgroundImage;
    UIGraphicsBeginImageContext(backButton.frame.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, UIColor.grayColor.CGColor);
    CGContextFillRect(contextRef, CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height));
    selectedBackgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    backButton.layer.masksToBounds = YES;
    [backButton.layer setCornerRadius:10.0];
    [backButton setBackgroundImage:selectedBackgroundImage forState:UIControlStateHighlighted];
    
    _habitBiz = [HabitBiz getInstance];
    PeriodTimesPickerViewController *periodTimesPickerViewController = [[PeriodTimesPickerViewController alloc] init];
    periodTimesPickerViewController.view = _periodTimesPicker;
    [periodTimesPickerViewController viewDidLoad];
    _periodTimesPicker.dataSource = periodTimesPickerViewController;
    _periodTimesPicker.delegate = periodTimesPickerViewController;
    
    // test grid picker
    GridPickerViewController *gridPickerViewController = [[GridPickerViewController alloc] init];
    gridPickerViewController.view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 80)];
    //gridPickerViewController.view.backgroundColor = UIColor.blueColor;
    for(NSInteger i = 1; i <= 6; ++i) {
        UILabel *timesLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        timesLable.text = [NSString stringWithFormat:@"%ld", i];
        [gridPickerViewController addCellView:timesLable];
    }
    gridPickerViewController.numberOfCellInRow = 6;
    gridPickerViewController.horizontalSpace = 10;
    gridPickerViewController.verticalSpace = 10;
    [gridPickerViewController layoutCellViews];
    gridPickerViewController selectCellView:<#(UIView *)#>
    
    [self addChildViewController:periodTimesPickerViewController];
    [self addChildViewController:gridPickerViewController];
    
    [navigationBarView addSubview:titleLable];
    [navigationBarView addSubview:backButton];
    [self.view addSubview:navigationBarView];
    [self.view addSubview:gridPickerViewController.view];
    
}

-(IBAction)back:(id)sender {
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
