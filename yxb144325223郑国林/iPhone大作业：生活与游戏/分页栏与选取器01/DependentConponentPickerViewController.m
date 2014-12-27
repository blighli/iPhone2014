//
//  DependentConponentPickerViewController.m
//  分页栏与选取器01
//
//  Created by CST-112 on 14-11-30.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import "DependentConponentPickerViewController.h"
#define NameComponent 0
#define PostComponent 1
@interface DependentConponentPickerViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *dependentPick;
- (IBAction)ButtonPressed:(UIButton *)sender;
@property (strong,nonatomic) NSArray *dependentName;
@property(strong,nonatomic) NSArray *dependentPost;
@property(strong,nonatomic) NSDictionary *statusZip;
@end

@implementation DependentConponentPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"statedictionary" withExtension:@"plist"];
    self.statusZip = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    NSArray *allkeys = [self.statusZip allKeys];
    
    NSArray *sortedStates = [allkeys sortedArrayUsingSelector:@selector(compare:)];
    self.dependentName = sortedStates;
    
    NSString *selected = self.dependentName[0];
    self.dependentPost = self.statusZip[selected] ;
    
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
    NSInteger nameRow = [self.dependentPick selectedRowInComponent:NameComponent];
    NSInteger postRow = [self.dependentPick selectedRowInComponent:PostComponent];
    NSString *name = self.dependentName[nameRow] ;
    NSString *post = self.dependentPost[postRow];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"你选择了 %@州，邮政编码是：%@",name,post] message:@"祝你生活愉快！" delegate:nil cancelButtonTitle:@"Welcome!" otherButtonTitles: nil];
    [alert show];
}
#pragma DateSource methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==NameComponent) {
        return self.dependentName.count;
    }else{
        return self.dependentPost.count;
    }
}
#pragma delegate methods
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==NameComponent) {
        return self.dependentName[row];
    }else
    {
        return self.dependentPost[row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==NameComponent) {
        NSString *selected = self.dependentName[row];
        self.dependentPost = self.statusZip[selected];
        [self.dependentPick reloadComponent:PostComponent];
        [self.dependentPick selectRow:0 inComponent:PostComponent animated:YES];
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component==NameComponent) {
        return 180;
    }else{
        return 110;
    }
}
@end
