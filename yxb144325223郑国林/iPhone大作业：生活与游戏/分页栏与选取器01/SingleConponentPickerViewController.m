//
//  SingleConponentPickerViewController.m
//  分页栏与选取器01
//
//  Created by CST-112 on 14-11-30.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import "SingleConponentPickerViewController.h"

@interface SingleConponentPickerViewController ()

@end

@implementation SingleConponentPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.characterName = @[@"Luke",@"linlei",@"babby",@"chenglong",@"guomeimei",@"ligang",@"xiaoming"];
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
    NSInteger row = [self.singlePiker selectedRowInComponent:0];
    NSString *selected = self.characterName[row];
    NSString *tittle = [[NSString alloc] initWithFormat:@"You selected %@",selected];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:tittle message:@"Thank you for choosing!" delegate:nil cancelButtonTitle:@"Welcome" otherButtonTitles: nil];
    [alert show];
}

#pragma mark Picker Date Source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.characterName count];
}

#pragma mark picker Dalegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.characterName[row];
}

@end
