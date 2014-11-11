//
//  ViewController.h
//  My-Caculator
//
//  Created by lzx on 14/11/9.
//  Copyright (c) 2014年 lzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *label;

-(IBAction)memorySelector:(UIButton *)sender;

-(IBAction)bracketSelector:(UIButton *)sender;

-(IBAction)deleteAndClearnSelector:(UIButton *)sender;

-(IBAction)caculateSelector:(UIButton *)sender;

-(IBAction)numberAndPointSelector:(UIButton *)sender;

@end

