//
//  ViewController.h
//  project2
//
//  Created by shazhouyouren on 14/11/4.
//  Copyright (c) 2014年 shazhouyouren. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString* error=@"ERROR";
@interface ViewController : UIViewController
@property NSString *m;
@property NSMutableString *exp;
@property NSMutableString *bufExp;
@property NSMutableArray *aryExp;

@property (weak, nonatomic) IBOutlet UILabel *labelResult;
@property (weak, nonatomic) IBOutlet UILabel *labelExp;

- (IBAction)clickZero:(id)sender;
- (IBAction)clickOne:(id)sender;
- (IBAction)clickTwo:(id)sender;
- (IBAction)clickThree:(id)sender;
- (IBAction)clickFour:(id)sender;
- (IBAction)clickFive:(id)sender;
- (IBAction)clickSix:(id)sender;
- (IBAction)clickSeven:(id)sender;
- (IBAction)clickEight:(id)sender;
- (IBAction)clickNine:(id)sender;

- (IBAction)clickDot:(id)sender;
- (IBAction)clickEqual:(id)sender;
- (IBAction)clickOperator:(id)sender;


- (IBAction)clickNeg:(id)sender;
- (IBAction)clickAC:(id)sender;
- (IBAction)clickDel:(id)sender;


- (IBAction)clickMR:(id)sender;
- (IBAction)clickMM:(id)sender;
- (IBAction)clickMP:(id)sender;
- (IBAction)clickMC:(id)sender;


@end

