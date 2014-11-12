//
//  ViewController.h
//  Computer Version2
//
//  Created by Steve on 14-11-10.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet  UITextField*  textField;
    NSMutableString *string;
    char str[100];//存储输入的运算字符串
    float temp;//用来保存MEMORY中得数值
    float num1,num2;
    int count;//记录输入的字符串长度
    int flag;
}

-(IBAction) MC;
-(IBAction) Mjia;
-(IBAction) Mjian;
-(IBAction) MR;
-(IBAction) Back;
-(IBAction) kuohao1;
-(IBAction) kuohao2;
-(IBAction) quyu;
-(IBAction) AC;
-(IBAction) chu;
-(IBAction) cheng;
-(IBAction) jian;
-(IBAction) jia;
-(IBAction) number1;
-(IBAction) number2;
-(IBAction) number3;
-(IBAction) number4;
-(IBAction) number5;
-(IBAction) number6;
-(IBAction) number7;
-(IBAction) number8;
-(IBAction) number9;
-(IBAction) number0;
-(IBAction) dian;
-(IBAction) deng;



@end

