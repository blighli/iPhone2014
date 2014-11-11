//
//  ViewController.h
//  MyCalculator
//
//  Created by rth on 14/11/4.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) NSString *lableString;
@property (strong,nonatomic) NSMutableArray *numArray;
@property (strong,nonatomic) NSMutableArray *opArray;
@property (nonatomic) double Number1;
@property (nonatomic) double Number2;
@property (nonatomic) double Memory;
@property (nonatomic) double Sum;
@property (nonatomic) int currentOp;
@property (nonatomic) double pointTag;


- (IBAction)MRButton:(id)sender; //MR
- (IBAction)MminusButton:(id)sender;//M-
- (IBAction)MAddButton:(id)sender;//M+
- (IBAction)MCAction:(id)sender;//MC
- (IBAction) numDigit:(id)sender; //数字键入
- (IBAction) operatorSelect:(id)sender;  //普通运算符(+ - * / =)
- (IBAction)dotOp:(id)sender;//小数点
- (IBAction) clearAll:(id)sender;//AC清除
- (IBAction)ZFchange:(id)sender;//正负号转换
- (IBAction)Del:(id)sender; //del

//声明：“ ( ”,“ ) "两种运算方法还未实现
- (void) display;

- (void) switchOP:(char) opt; ///算法选择


- (NSString *) deletePointZreo:(NSString *) str;

- (NSString *) deletePreZreo:(NSString *) str;


@end

