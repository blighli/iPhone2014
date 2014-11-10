//
//  ViewController.h
//  calculator
//
//  Created by 杨长湖 on 14/11/7.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSString *showNumber;
    double inputNumber;
    double resultNumber;
    double number;
    BOOL dot_Sign;
    int dot_length;
    int operators;
    int operator_Sign;
    BOOL resultOutPut_Sign;
    double M;
}

@property (weak, nonatomic) IBOutlet UILabel *calOutlet;

- (IBAction)numberButtenTouch:(UIButton *)sender;
- (IBAction)dotButtenTouch:(UIButton *)sender;
- (IBAction)ACButtenTouch:(UIButton *)sender;
- (IBAction)operatorButtenTouch:(UIButton *)sender;
- (IBAction)resultOutPut:(UIButton *)sender;
- (IBAction)Madd:(UIButton *)sender;
- (IBAction)Mmin:(UIButton *)sender;
- (IBAction)MC:(UIButton *)sender;
- (IBAction)MR:(UIButton *)sender;


- (double) buildNumber:(double)num andbN:(double)number;
- (NSString *)floatToString:(double)number;
- (void) calculate:(int)operators;

@end

