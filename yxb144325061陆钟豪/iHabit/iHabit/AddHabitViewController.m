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
#import "TimesPickerController.h"
#import "PeriodPickerController.h"

@interface AddHabitViewController ()

@end

@implementation AddHabitViewController {
    HabitBiz* _habitBiz;
    TimesPickerController *_timesPickerController;
    PeriodPickerController *_periodPickerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //这个标准默认为YES，如果设置为NO，这消息一旦传递给subView，这scroll事件不会再发生。
    self.scrollView.canCancelContentTouches = NO;
    
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
    
    _timesPickerController = [[TimesPickerController alloc] init];
    _timesPickerController.view = self.timesPicker;
    [_timesPickerController viewDidLoad];
    
    _periodPickerController = [[PeriodPickerController alloc] init];
    _periodPickerController.view = self.periodPicker;
    [_periodPickerController viewDidLoad];
    
    [self addChildViewController:_timesPickerController];
    [self addChildViewController:_periodPickerController];
    
    [navigationBarView addSubview:titleLable];
    [navigationBarView addSubview:backButton];
    [self.view addSubview:navigationBarView];
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
    [_habitBiz saveHabitWithTitle: self.habitTextField.text
                          iconName: @"star" period:[_periodPickerController selectedPeriod]
                            times: [NSNumber numberWithInteger:[_timesPickerController selectedTimes]]];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
