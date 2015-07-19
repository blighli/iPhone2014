//
//  DatePickerViewController.m
//  分页栏与选取器01
//
//  Created by CST-112 on 14-11-30.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *now = [NSDate date];
    [self.datePicker setDate:now animated:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ButtonPressed:(UIButton *)sender {
    
    NSDate *selected = [self.datePicker date];
    NSString *message = [[NSString alloc] initWithFormat:@"The date and time you selected is:%@",selected];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"date and time selected " message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles :nil];
    [alert show];
}
@end
