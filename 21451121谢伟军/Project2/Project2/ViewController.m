//
//  ViewController.m
//  Project2
//
//  Created by xvxvxxx on 14/11/4.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *labelScreen;
@property (strong, nonatomic) CalculateProcess *myCalculale;

@property (nonatomic) BOOL dotTag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.labelScreen.adjustsFontSizeToFitWidth = YES;
    self.labelScreen.numberOfLines = 1;
    self.myCalculale = [[CalculateProcess alloc]init];
    self.dotTag = NO;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma buttonMemory
- (IBAction)buttonMemory:(UIButton *)sender {
    double memoryNumber = [self.myCalculale.memoryString doubleValue];
    switch (sender.tag) {
        case 1:
            memoryNumber = 0;
            break;
        case 2:
            memoryNumber += self.myCalculale.currentNumber;
            break;
        case 3:
            memoryNumber -= self.myCalculale.currentNumber;
            break;
        case 4:
            self.myCalculale.displayString = self.myCalculale.memoryString;
            NSInteger length = [self.myCalculale.displayString length];
            while ([self.myCalculale.displayString characterAtIndex:(length-1)] == '0') {
                self.myCalculale.displayString = [NSMutableString stringWithString:[self.myCalculale.displayString substringToIndex:length-1]];
                length--;
            }
            if ([self.myCalculale.displayString characterAtIndex:(length-1)] == '.') {
                self.myCalculale.displayString = [NSMutableString stringWithString:[self.myCalculale.displayString substringToIndex:length-1]];
            }

            [self.myCalculale displayNumberatScreen:self.labelScreen];
        default:
            break;
    }
    self.myCalculale.memoryString = [NSMutableString stringWithString:[NSString stringWithFormat:@"%lf",memoryNumber]];
}



#pragma button
- (IBAction)buttonDelete:(UIButton *)sender {
}

- (IBAction)buttonLeftBrackets:(UIButton *)sender {
}
- (IBAction)buttonRightBrackets:(UIButton *)sender {
}
- (IBAction)buttonPercent:(UIButton *)sender {
}

- (IBAction)buttonAC:(UIButton *)sender {
    self.myCalculale.currentNumber = 0;
    self.myCalculale.lastNumber = 0;
    self.dotTag = NO;
    self.myCalculale.displayString = [NSMutableString stringWithString:@""];
    self.labelScreen.text = @"0";
}

- (IBAction)buttonDivide:(UIButton *)sender {
}

- (IBAction)buttonMultiply:(UIButton *)sender {
}

- (IBAction)buttonMinus:(UIButton *)sender {
}

- (IBAction)buttonPlus:(UIButton *)sender {
}

- (IBAction)buttonPlusOrMinus:(UIButton *)sender {
}

- (IBAction)buttonEqual:(UIButton *)sender {
}

#pragma buttonDot
- (IBAction)buttonDot:(UIButton *)sender {
    if (!self.dotTag) {
        self.dotTag = YES;
        
        if ([self.myCalculale.displayString isEqualToString:@""]) {
            [self.myCalculale.displayString appendString:@"0."];

        }else{
            [self.myCalculale processDot];
        }
        [self.myCalculale displayNumberatScreen:self.labelScreen];
    }
}

#pragma buttonDigit
- (IBAction)buttonDigit:(UIButton *)sender {
    NSString *inputDigit = sender.titleLabel.text;
    NSInteger digit = [inputDigit intValue];
    if ([self.myCalculale.displayString isEqualToString:@"0"]) {
        [self.myCalculale.displayString deleteCharactersInRange:[self.myCalculale.displayString rangeOfString:@"0"]];
        if (digit == 0) {
            return;
        }
    }
    [self.myCalculale processDigit:digit];
    [self.myCalculale displayNumberatScreen:self.labelScreen];
}

#pragma 改变状态栏颜色为亮色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
