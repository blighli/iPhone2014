//
//  ViewController.h
//  MyCalculator
//
//  Created by alwaysking on 14/11/3.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSString *lableString;
@property (strong,nonatomic) NSMutableArray *numArray;
@property (strong,nonatomic) NSMutableArray *opArray;


@property (nonatomic) int currentOp;
@property (nonatomic) double opNum1;
@property (nonatomic) double opNum2;
@property (nonatomic) double opMemory;
@property (nonatomic) double currentSum;

@property (nonatomic) double pointTag;


- (IBAction) numDigit:(id)sender;
- (IBAction) operatorSelect:(id)sender;
- (IBAction) exPoint:(id)sender;
- (IBAction) clearAll:(id)sender;
- (IBAction) equelOp:(id)sender;
- (IBAction) zhengFuOp;
- (void) Compute:(char) opt;
- (int) compareChPop:(char) ch1 andChB:(char)ch2;
- (IBAction) mOperator:(id)sender;
- (IBAction) backSpace:(id)sender;
- (void) showLable;
- (NSString *) deletePointZreo:(NSString *) str;
- (NSString *) deletePreZreo:(NSString *) str;


@end

