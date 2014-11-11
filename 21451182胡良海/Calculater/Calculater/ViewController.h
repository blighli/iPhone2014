//
//  ViewController.h
//  Calculater
//
//  Created by hu on 14/11/4.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)memoryControl:(UIButton *)sender;

- (IBAction)deleteandclean:(UIButton *)sender;

- (IBAction)bracket:(UIButton *)sender;

- (IBAction)calculate:(UIButton *)sender;

- (IBAction)numberandpoint:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITextField *numberandResult;

-(IBAction)backgroundTap:(id)sender;

@end

