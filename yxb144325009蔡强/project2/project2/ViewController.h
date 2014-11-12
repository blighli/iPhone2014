//
//  ViewController.h
//  project2
//
//  Created by zack on 14-11-9.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property double M;
@property (weak, nonatomic) IBOutlet UITextField *formula;
- (NSString*)formatNumStr:(NSString*)str;//智能控制小数点位数
- (BOOL)compare:(NSString*)str :(NSMutableArray*)priStack;//比较操作符优先级
- (NSString*)cal;//读取字符串计算结果
- (IBAction)action_mc:(id)sender;
- (IBAction)action_mPlus:(id)sender;
- (IBAction)action_mMinus:(id)sender;
- (IBAction)action_mr:(id)sender;
- (IBAction)action_del:(id)sender;
- (IBAction)action_leftB:(id)sender;
- (IBAction)action_rightB:(id)sender;
- (IBAction)action_complementation:(id)sender;
- (IBAction)action_ac:(id)sender;
- (IBAction)action_division:(id)sender;
- (IBAction)action_multiplication:(id)sender;
- (IBAction)action_minus:(id)sender;
- (IBAction)action_7:(id)sender;
- (IBAction)action_8:(id)sender;
- (IBAction)action_9:(id)sender;
- (IBAction)action_plus:(id)sender;
- (IBAction)action_4:(id)sender;
- (IBAction)action_5:(id)sender;
- (IBAction)action_6:(id)sender;
- (IBAction)action_plusminus:(id)sender;
- (IBAction)action_1:(id)sender;
- (IBAction)action_2:(id)sender;
- (IBAction)action_3:(id)sender;
- (IBAction)action_cal:(id)sender;
- (IBAction)action_0:(id)sender;
- (IBAction)action_point:(id)sender;

@end

