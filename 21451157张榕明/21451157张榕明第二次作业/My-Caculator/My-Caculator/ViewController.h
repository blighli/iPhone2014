//
//  ViewController.h
//  My-Caculator
//
//  Created by 张榕明 on 14/11/9.
//  Copyright (c) 2014年 张榕明. All rights reserved.
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

