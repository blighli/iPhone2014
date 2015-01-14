//
//  ViewController.h
//  Homework2
//
//  Created by 李丛笑 on 14/11/5.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSMutableString * textstr;
    NSMutableString * numstr;
}

@property (weak, nonatomic) IBOutlet UITextView *textView;

//-(void) settstr: (NSMutableString *)textstr;


- (IBAction)zero;
- (IBAction)dot;
- (IBAction)one;
- (IBAction)two;
- (IBAction)three;
- (IBAction)four;
- (IBAction)five;
- (IBAction)six;
- (IBAction)seven;
- (IBAction)eight;
- (IBAction)nine;
- (IBAction)plus;
- (IBAction)minus;
- (IBAction)multiple;
- (IBAction)divide;
- (IBAction)left;
- (IBAction)right;
- (IBAction)percent;
- (IBAction)back;
- (IBAction)ac;
- (IBAction)mod;
- (IBAction)mplus;
- (IBAction)mminus;
- (IBAction)mc;
- (IBAction)mr;
- (IBAction)equles;



@end

