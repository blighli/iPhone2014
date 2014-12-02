//
//  ViewController.m
//  EverNote
//
//  Created by 陈晓强 on 14/11/28.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "ViewController.h"
#import "IQKeyboardManager.h"
@interface ViewController ()
@property (strong, nonatomic) NSMutableAttributedString *dataString;

@end

@implementation ViewController
{
    BOOL _wasKeyboardManagerEnabled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setKeyboard];
    _textView.delegate = self;
    _textField.delegate = self;
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}
#pragma mark - keyboard action

- (void) setKeyboard
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * button =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto)];
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                                                  target:self action:@selector(resignKeyboard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:button,button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    [_textView setInputAccessoryView:topView];
    [_textField setInputAccessoryView:topView];
}

- (void)takePhoto
{
    
}
- (void) resignKeyboard
{
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];

}

- (IBAction)backgroundTap:(id)sender{
//    [self.textView resignFirstResponder];
//    [self.textField resignFirstResponder];

}





@end
