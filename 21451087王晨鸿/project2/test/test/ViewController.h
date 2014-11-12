//
//  ViewController.h
//  test
//
//  Created by qtsh on 14-11-6.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//
#import "StringCalculator.h"

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSMutableString * show;
    float  memory;
}
@property (nonatomic,assign) IBOutlet UITextField * showField;
@property NSMutableString* show;
-(BOOL)isInteger:(NSString*)input;
-(void)set_show:(NSString*)newShow;
-(IBAction)btn_1_click;
-(IBAction)btn_2_click;
-(IBAction)btn_3_click;
-(IBAction)btn_4_click;
-(IBAction)btn_5_click;
-(IBAction)btn_6_click;
-(IBAction)btn_7_click;
-(IBAction)btn_8_click;
-(IBAction)btn_9_click;
-(IBAction)btn_0_click;
-(IBAction)btn_MC_click;
-(IBAction)btn_MP_click;
-(IBAction)btn_MM_click;
-(IBAction)btn_MR_click;
-(IBAction)btn_BACK_click;
-(IBAction)btn_L_click;
-(IBAction)btn_R_click;
-(IBAction)btn_MOD_click;
-(IBAction)btn_PLUSS_click;
-(IBAction)btn_MINUS_click;
-(IBAction)btn_MULTI_click;
-(IBAction)btn_DIVID_click;
-(IBAction)btn_AC_click;
-(IBAction)btn_EQUAL_click;
-(IBAction)btn_DOT_click;
-(IBAction)btn_POSORNEG_click;
@end

