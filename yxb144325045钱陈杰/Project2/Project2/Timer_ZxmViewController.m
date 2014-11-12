//
//  Timer_ZxmViewController.m
//  Project2
//
//  Created by qianchj on 14-11-9.
//  Copyright (c) 2014年 qianchj. All rights reserved.
//

#import "Timer_ZxmViewController.h"

@interface Timer_ZxmViewController ()

@end

@implementation Timer_ZxmViewController
@synthesize display;

- (void)viewDidLoad
{
    [super viewDidLoad];
	MR_value = 0;
    op_Sign = NO;
	dot_Sign = NO;
	dot_Length = 0;
	result_left = 0;
	is_Left = YES;
	is_Operator = 0;
	judge_Bug = NO;
	ori = @"0";
	judge_dotBug = NO;
	bug = YES;
	is_op = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)numberTouch:(UIButton *)sender {
    
    UIButton *btn_Number = (UIButton *)sender;
	if (op_Sign == NO) {
		if ([[self changeFloat:result_left]length] >=18) {
			return;
		}
		left = [[btn_Number currentTitle] integerValue];
        if (judge_Bug == YES) {
            result_left = 0;
        }
        if(dot_Sign == NO) {
            result_left = result_left * 10 +left;
            show_Save = [self changeFloat:result_left];
        }
        else {
            dot_Length++;
            result_left = result_left + pow(0.1,dot_Length) * left;
            if (left == 0) {
                show_Save = [NSString stringWithFormat:@"%@%@",show_Save,ori];
            }
            else {
                show_Save = [self changeFloat:result_left];
            }
        }
		display.text = show_Save;
		judge_Bug = NO;
		if (bug_x == YES) {
            result_right = 0;
		}
		else if (bug_x == NO) {
            result_right = 1;
		}
		is_op = YES;
	}
	else {
		if ([[self changeFloat:result_right]length] >=18) {
			return;
		}
		right = [[btn_Number currentTitle] integerValue];
        if(dot_Sign == NO) {
            result_right = result_right * 10 +right;
            show_Save = [self changeFloat:result_right];
        }
        else {
            dot_Length++;
            result_right = result_right + pow(0.1,dot_Length) * right;
            if (right == 0) {
                show_Save = [NSString stringWithFormat:@"%@%@",show_Save,ori];
            }
            else {
                show_Save = [self changeFloat:result_right];
            }
        }
        
		display.text = show_Save;
		is_Left = YES;
		is_op = NO;
	}
	judge_dotBug = NO;

}

- (IBAction)acClear:(UIButton *)sender {
    op_Sign = NO;
	dot_Sign = NO;
	dot_Length = 0;
	result_left = 0;
	result_right = 0;
	is_Left = YES;
	is_Operator = 0;
	judge_Bug = NO;
	display.text = @"0";
	judge_dotBug = NO;
	bug = YES;
	is_op = YES;
}

- (IBAction)operatePressed:(UIButton *)sender {
    UIButton *btn_Operator = (UIButton *)sender;
	if (op_Sign == YES && is_Left == YES) {
		[self calculate:is_Operator];
	}
	is_Operator = btn_Operator.tag;
	op_Sign = YES;
	is_Left = NO;
	dot_Sign = NO;
	result_right = 0;
	dot_Length = 0;
	judge_dotBug = NO;
	bug = YES;
	is_op = NO;
}

- (IBAction)symbolChange:(id)sender {
    if (is_op == YES) {
        result_left = 0 - result_left;
        display.text = [self changeFloat:result_left];
	}
	else {
        result_right = 0 - result_right;
        display.text = [self changeFloat:result_right];
	}
}

- (IBAction)output:(id)sender {
    [self calculate:is_Operator];
	op_Sign = NO;
	judge_Bug = YES;
	dot_Sign = NO;
	dot_Length = 0;
	left = 0;
	judge_dotBug = YES;
	bug = YES;
	is_op = YES;
}

- (IBAction)dotButton:(id)sender {
    dot_Sign = YES;
	if (bug == YES) {
		if (op_Sign == NO) {
			show_Save = [NSString stringWithFormat:@"%@.",[self changeFloat:result_left]];
			display.text = show_Save;
		}
		else {
			show_Save = [NSString stringWithFormat:@"%@.",[self changeFloat:result_right]];
			display.text = show_Save;
		}
		bug = NO;
	}
	if (judge_dotBug == YES) {
		result_left = 0;
		show_Save = @"0.";
		display.text = show_Save;
	}
	judge_dotBug = NO;
}

- (IBAction)MC:(id)sender {
    MR_value = 0;
    [self clear];
	display.text = @"0";
}

- (IBAction)MAdd:(id)sender {
    MR_value = MR_value+[display.text doubleValue];
    [self clear];
}

- (IBAction)MMinus:(id)sender {
    MR_value = MR_value-[display.text doubleValue];
    [self clear];
}

- (IBAction)MR:(id)sender {
    show_Save = [self changeFloat:MR_value];
    display.text = show_Save;
    [self clear];
}

- (void) clear
{
    op_Sign = NO;
	dot_Sign = NO;
	dot_Length = 0;
	result_left = 0;
	result_right = 0;
	is_Left = YES;
	is_Operator = 0;
	judge_Bug = NO;
	judge_dotBug = NO;
	bug = YES;
	is_op = YES;
}

- (void) showError:(NSString *) error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error！"
                                                    message:error
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) calculate:(int)is_What {
    NSLog(@"%d ----",is_What);
    switch (is_What) {
		case 1:
			result_left = result_left + result_right;
			show_Save = [self changeFloat:result_left];
			if ([[self changeFloat:result_left]length] > 18) {
				[self showError:@"The result is too large！"];
				show_Save = @"0";
				result_left = 0;
			}
			display.text = show_Save;
			bug_x = YES;
			break;
		case 2:
			result_left = result_left - result_right;
			show_Save = [self changeFloat:result_left];
			if ([[self changeFloat:result_left]length] > 18) {
				[self showError:@"The result is too large！"];
				show_Save = @"0";
				result_left = 0;
			}
			display.text = show_Save;
			bug_x = YES;
			break;
		case 3:
			result_left = result_left * result_right;
			show_Save = [self changeFloat:result_left];
			if ([[self changeFloat:result_left]length] > 18) {
				[self showError:@"The result is too large！"];
				show_Save = @"0";
				result_left = 0;
			}
			display.text = show_Save;
			bug_x = NO;
			break;
		case 4:
			if (result_right == 0) {
				[self showError:@"Divisor must not be zero！"];
				return;
			}
			result_left = result_left / result_right;
			show_Save = [self changeFloat:result_left];
			if ([[self changeFloat:result_left]length] > 18) {
				[self showError:@"The result is too large！"];
				show_Save = @"0";
				result_left = 0;
			}
			display.text = show_Save;
			bug_x = NO;
			break;
        case 5:
            rleft = (int)result_left;
            rright = (int)result_right;
            if (result_left-rleft == 0 && result_right-rright == 0 && rright!=0) {
                result_left = rleft%rright;
            } else {
                [self showError:@"Only integer can mod！"];
				return;
            }
			show_Save = [self changeFloat:result_left];
			if ([[self changeFloat:result_left]length] > 18) {
				[self showError:@"The result is too large！"];
				show_Save = @"0";
				result_left = 0;
			}
			display.text = show_Save;
			bug_x = NO;
			break;
		default:
			break;
	}
	if ([[self changeFloat:result_left] isEqualToString:@"-0"]) {
		display.text = @"0";
	}
}

- (NSString *)changeFloat:(double)Right {
    NSString *stringFloat;
	stringFloat = [NSString stringWithFormat:@"%.12f",Right];
	const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0') {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}


@end
