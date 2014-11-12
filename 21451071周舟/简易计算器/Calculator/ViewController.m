//
//  ViewController.h
//  Calculator
//
//  Created by 周舟 on 4/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "ViewController.h"
#import "Calculate.h"


@interface ViewController()

@property (nonatomic, assign) double mNumber;


@property(nonatomic, copy) NSString *expressStr;

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (nonatomic, strong) Calculate *calculation;

@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    _expressStr = @"0";
    self.mNumber = 0;
    self.textFiled.text = self.expressStr;
    Calculate *calculation = [[Calculate alloc] init];
    self.calculation = calculation;
    
}
#pragma mark MR/MC/M+/M-
//
- (IBAction)mClear:(id)sender {
    self.mNumber = 0;
}

- (IBAction)mAdd:(id)sender {
    
    if ([self.textFiled.text containsString:@"+"] || [self.textFiled.text containsString:@"/"] || [self.textFiled.text containsString:@"-"] || [self.textFiled.text containsString:@"x"] || [self.textFiled.text containsString:@"("] || [self.textFiled.text containsString:@")"]) {
        return;
    }
    self.mNumber += [self.textFiled.text doubleValue];
    
}

- (IBAction)mSub:(id)sender {
    if ([self.textFiled.text containsString:@"+"] || [self.textFiled.text containsString:@"/"] || [self.textFiled.text containsString:@"-"] || [self.textFiled.text containsString:@"x"] || [self.textFiled.text containsString:@"("] || [self.textFiled.text containsString:@")"]) {
        return;
    }
    self.mNumber -= [self.textFiled.text doubleValue];
}

- (IBAction)mR:(id)sender {

    double r1 = self.mNumber;
    int r2 = (int)self.mNumber;
    
    if ( r2 < r1) {
        self.textFiled.text = [NSString stringWithFormat:@"%.2f", r1];
        
    }else{
        self.textFiled.text = [NSString stringWithFormat:@"%d",r2];
    }
}
#pragma mark 其他方法
/**
 *  AC
 *
 *  @param sender <#sender description#>
 */
- (IBAction)allClear:(id)sender {
    self.textFiled.text = @"0";
    self.mNumber = 0;
}
/**
 *  +/-
 *
 *  @param sender <#sender description#>
 */
- (IBAction)reverseSymble:(id)sender {
    double temp = [self.textFiled.text doubleValue];
    temp = temp * (-1);
    
    double r1 = temp;
    int r2 = (int)temp;
    if ( r2 < r1) {
        self.textFiled.text = [NSString stringWithFormat:@"%.2f", r1];
        
    }else{
        self.textFiled.text = [NSString stringWithFormat:@"%d",r2];
    }
    
}
/**
 *  =
 *
 *  @param sender <#sender description#>
 */
- (IBAction)enter:(id)sender {
   NSString *result = [self.calculation calculateWithExpress:self.textFiled.text];
    float r1 = [result floatValue];
    int r2 = (int)[result integerValue];
    if ( r2 < r1) {
        self.textFiled.text = [NSString stringWithFormat:@"%.2f", r1];
        
    }else{
        self.textFiled.text = [NSString stringWithFormat:@"%d",r2];
    }
    
    
}
/**
 *  删除一个
 *
 *  @param sender <#sender description#>
 */
- (IBAction)delete:(id)sender {
    if (![self.textFiled.text isEqualToString:@""]) {
      self.textFiled.text = [@"" stringByAppendingString:[self.textFiled.text substringToIndex:self.textFiled.text.length - 1]];
    }
}

/**
 *  1~9 + - x % / ( )
 *
 *  @param sender <#sender description#>
 */
- (IBAction)btnClick:(UIButton *)sender {
    //NSLog(@"%@",[sender titleForState:UIControlStateNormal]);
    if ([self.textFiled.text isEqualToString:@"0"]) {
        
        self.textFiled.text = [sender titleForState:UIControlStateNormal];
    }
    else{
        self.textFiled.text = [self.textFiled.text stringByAppendingString:[sender titleForState:UIControlStateNormal]];
    }
}


@end