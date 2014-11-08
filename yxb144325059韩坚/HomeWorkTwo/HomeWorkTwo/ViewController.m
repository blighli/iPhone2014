//
//  ViewController.m
//  HomeWorkTwo
//
//  Created by HJ on 14/11/3.
//  Copyright (c) 2014年 HJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableString             *displayString;
    FormulaStringCalcUtility    *myFormulaStringCalcUtility;
    CGFloat                     menoryPlus;
    NSString                    *result;
   
}

@synthesize display;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    displayString = [NSMutableString stringWithCapacity: 40];
    menoryPlus = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//数字键
-(IBAction) clickDigit:(UIButton *)sender
{
    [self senbtclickwithBlock:^{
        [displayString appendString: [NSString stringWithFormat: @"%i", (int)sender.tag]];
    }and: sender];
}
//退格
- (IBAction)clickDelete:(UIButton *)sender
{
    [sender setShowsTouchWhenHighlighted:YES];
    if ([displayString length] > 0)
    {
        NSString *strCopy = [displayString mutableCopy];
        strCopy = [strCopy substringToIndex:([strCopy length]-1)];
        displayString = [strCopy mutableCopy];
    }
    display.text = displayString;
    NSLog(@"%@",displayString);
}
//AC
- (IBAction)clickAC:(UIButton *)sender
{
    [sender setShowsTouchWhenHighlighted:YES];
    
    displayString = [NSMutableString stringWithCapacity: 40];
    display.text = displayString;
    NSLog(@"%@",displayString);
}
//***********"+-*/()."**************************************************begin
- (void) senbtclickwithBlock: (void(^)()) myblock and:(UIButton *) sender
{
   [sender setShowsTouchWhenHighlighted:YES];
    myblock();
    display.text = displayString;
    NSLog(@"%@",displayString);
}

- (IBAction)clickPoint:(UIButton *)sender {
    [self senbtclickwithBlock:^{
        [displayString appendString: [NSString stringWithFormat: @"."]];
    }and: sender];
}

- (IBAction)clickAdd:(UIButton *)sender {
    [self senbtclickwithBlock:^{
        [displayString appendString: [NSString stringWithFormat: @"+"]];
    }and: sender];
}

- (IBAction)clickMinus:(UIButton *)sender {
    [self senbtclickwithBlock:^{
        [displayString appendString: [NSString stringWithFormat: @"-"]];
    }and: sender];
}

- (IBAction)clickMultiply:(UIButton *)sender {
    [self senbtclickwithBlock:^{
        [displayString appendString: [NSString stringWithFormat: @"*"]];
    }and: sender];
}

- (IBAction)clickDivide:(UIButton *)sender {
    [self senbtclickwithBlock:^{
        [displayString appendString: [NSString stringWithFormat: @"/"]];
    }and: sender];
}

- (IBAction)clickLeftParet:(UIButton *)sender {
    [self senbtclickwithBlock:^{
        [displayString appendString: [NSString stringWithFormat: @"("]];
    }and: sender];
}

- (IBAction)clickRightParet:(UIButton *)sender {
    [self senbtclickwithBlock:^{
        [displayString appendString: [NSString stringWithFormat: @")"]];
    }and: sender];
}
//***********"+-*/()."**********************************************************end
//取余数
- (IBAction)clickRemain:(UIButton *)sender {
    [self senbtclickwithBlock:^{
        [displayString appendString: [NSString stringWithFormat: @"%%"]];
    }and: sender];
}
//字符串计算
- (BOOL) stringToCaculator
{
    BOOL myBool = YES;
    NSArray *rightArray = [displayString componentsSeparatedByString:@")"];
    NSArray *leftArray = [displayString componentsSeparatedByString:@"("];
    
    NSString *regex=@"(^([\\*\\/\\)\\%].*))|(.*\\)\\d.*)|(.*[\\*\\/\\+\\-][\\*\\/\\)].*)|(.*[\\*\\/\\%][\\*\\/\\%].*)|(.*[\\*\\/\\%][\\*\\/\\%\\+\\-].*)|(.*\\.\\d\\..*)|(.*\\([\\*\\/\\%])|(.*[\\+\\-\\*\\/\\%]\\).*)|(.*\\d\\(.*)|(.*\\.\\(.*)|((.*[\\*\\+\\-\\/\\(\\%])$)";

    if (![displayString isMatchedByRegex: regex] && (rightArray.count == leftArray.count))
    {
        NSLog(@"通过校验！");
        //NSString *result;
        result = [FormulaStringCalcUtility calcComplexFormulaString: displayString];
        if (result.length == 0)
        {
            result = @"格式错误";
            myBool = NO;
        }
        NSLog(@"%@",result);
    }
    else
    {
        result = @"错误格式";
        myBool = NO;
        NSLog(@"未通过校验，数据格式有误，请检查！");
    }
    return myBool;
}
//等于 "="
- (IBAction)clickEqual:(UIButton *)sender
{
    [sender setShowsTouchWhenHighlighted:YES];
    if([self stringToCaculator] == YES)
    {
        displayString = [NSMutableString stringWithCapacity: 40];
    }
    display.text = result;
}
//*********************MCM+M-MR****************************************************begin
- (void) senMclickwithBlock: (void(^)()) myblock and:(UIButton *) sender
{
    [sender setShowsTouchWhenHighlighted:YES];
    if([self stringToCaculator] == YES)
    {
        myblock();
        display.text = [NSString stringWithFormat:@"%.2f",menoryPlus];
        displayString = [NSMutableString stringWithCapacity: 40];
    }
    else
    {
        display.text = result;
    }
}

- (IBAction)clickMc:(UIButton *)sender {
    [sender setShowsTouchWhenHighlighted:YES];
    menoryPlus = 0.0;
    display.text = [NSString stringWithFormat:@"%.2f",menoryPlus];
}

- (IBAction)clickMadd:(UIButton *)sender {
    [self senMclickwithBlock: ^{
        menoryPlus = menoryPlus + (CGFloat)[result floatValue];
    } and: sender];
}

- (IBAction)clickMminus:(UIButton *)sender {
    [self senMclickwithBlock: ^{
        menoryPlus = menoryPlus - (CGFloat)[result floatValue];
    } and: sender];
}

- (IBAction)clickMresult:(UIButton *)sender {
     display.text = [NSString stringWithFormat:@"%.2f",menoryPlus];
}
//*********************MCM+M-MR*********************************************************end
@end
