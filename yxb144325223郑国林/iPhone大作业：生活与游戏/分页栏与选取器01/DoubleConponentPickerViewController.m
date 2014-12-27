//
//  DoubleConponentPickerViewController.m
//  分页栏与选取器01
//
//  Created by CST-112 on 14-11-30.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import "DoubleConponentPickerViewController.h"
#define nameComponent 0
#define foodComponent 1
@interface DoubleConponentPickerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *DoublePicker;


- (IBAction)buttonPressed:(UIButton *)sender;
@property(strong,nonatomic) NSArray *charinformationName;
@property(strong,nonatomic ) NSArray *charinformationFood;
@end

@implementation DoubleConponentPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.charinformationName = @[@"Luke",@"linlei",@"babby",@"chenglong",@"guomeimei",@"ligang",@"xiaoming"];
    self.charinformationFood = @[@"pie",@"apple",@"milk",@"pear",@"bananer",@"orange",@"pig"];
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

- (IBAction)buttonPressed:(UIButton *)sender {
    NSInteger namerow = [self.DoublePicker selectedRowInComponent:nameComponent];
    NSInteger foodrow  = [self.DoublePicker selectedRowInComponent:foodComponent];
    NSString * name = self.charinformationName[namerow];
    NSString* food = self.charinformationFood[foodrow];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"name is %@,food is %@",name,food] message:@"Thank you for your order!" delegate:nil cancelButtonTitle:@"Welcome!" otherButtonTitles: nil];
    [alert show];
}

#pragma Date source methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==nameComponent) {
        return self.charinformationName.count;
    }else{
        return self.charinformationFood.count;
    }
}
#pragma picker Delegate methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==nameComponent) {
        return self.charinformationName[row];
    }else{
        return self.charinformationFood[row];
    }
}
@end
