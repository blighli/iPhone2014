//
//  Timer_ZxmViewController.h
//  Project2
//
//  Created by qianchj on 14-11-9.
//  Copyright (c) 2014年 qianchj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Timer_ZxmViewController : UIViewController {
    double MR_value;    //储存MR
    int rleft,rright;   //储存mod运算的两个数
	double left;
	double result_left;
	double right;
	double result_right;
	BOOL op_Sign;
	BOOL is_Left;
	BOOL dot_Sign;
	BOOL judge_Bug;
	int dot_Length;
	int is_Operator;
	BOOL judge_dotBug;
	NSString *show_Save;
	NSString *ori;
	BOOL bug;
	BOOL is_op;
	BOOL bug_x;
}

@property (weak, nonatomic) IBOutlet UILabel *display;

- (IBAction)numberTouch:(UIButton *)sender; //输入数字
- (IBAction)acClear:(UIButton *)sender; //AC清除
- (IBAction)operatePressed:(UIButton *)sender; //符号输入
- (IBAction)symbolChange:(id)sender; //正负号转换
- (IBAction)output:(id)sender; //输出
- (IBAction)dotButton:(id)sender; //增加一个.
- (IBAction)MC:(id)sender; //MC
- (IBAction)MAdd:(id)sender; //M+
- (IBAction)MMinus:(id)sender; //M-
- (IBAction)MR:(id)sender; //MR

- (void) clear;
- (void) showError:(NSString *)error;
- (void) calculate:(int)result; //计算结果
- (NSString *)changeFloat:(double)Right; //转换类型

@end
