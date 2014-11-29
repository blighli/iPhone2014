//
//  ViewController.m
//  EverNote
//
//  Created by 陈晓强 on 14/11/28.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setKeyboard];
    _textView.delegate = self;
    _textField.delegate = self;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - keyboard action


-(void)keyboardDidShow:(NSNotification *)notification

{

    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];

    CGRect keyboardRect;

    [keyboardObject getValue:&keyboardRect];

    [UIView beginAnimations:nil context:nil];

    [UIView setAnimationDuration:0.2];

    [(UIView *)[self.view viewWithTag:1000] setFrame:CGRectMake(0, -216, 320, 568)];

    [UIView commitAnimations];

}
- (void) setKeyboard
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                                                  target:self action:@selector(resignKeyboard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    [_textView setInputAccessoryView:topView];
    [_textField setInputAccessoryView:topView];
}
- (void) resignKeyboard
{
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (IBAction)backgroundTap:(id)sender{
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    float  offset = 216.0; //view向上移动的距离
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = _myView.frame.size.width;
//    float height = _myView.frame.size.height;
//    NSLog(@"%f %f",width,height);
//    CGRect rect = CGRectMake(0.0f,  offset , width, height);
//    _myView.frame = rect;
//    [UIView  commitAnimations];
}
//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
//    float  offset = xx; //view向上移动的距离
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    float width = self.view.frame.size.width;
//    float height = self.view.frame.size.height;
//    CGRect rect = CGRectMake(0.0f, offset , width, height);
//    self.view.frame = rect;
//    [UIView  commitAnimations];
//}


@end
