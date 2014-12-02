//
//  ViewController.m
//  Test
//
//  Created by 陈晓强 on 14/11/29.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "ViewController.h"
#import "DaiDodgeKeyboard.h"
#import "IQKeyboardManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *myView;

@end

@implementation ViewController
{
    BOOL _wasKeyboardManagerEnabled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _textView.scrollEnabled = YES;
    _textView.delegate = self;
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                                                  target:self action:@selector(resignKeyboard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    [_textView setInputAccessoryView:topView];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void) resignKeyboard
{
//    [DaiDodgeKeyboard removeRegisterTheViewNeedDodgeKeyboard];
    [self.textView resignFirstResponder];
//    [self.textField resignFirstResponder];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
}
@end
