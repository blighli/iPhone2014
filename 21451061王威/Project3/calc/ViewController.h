//
//  ViewController.h
//  calc
//
//  Created by 王威 on 14/11/7.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *displayField;

- (IBAction)memoryOperation:(UIButton *)sender;

- (IBAction)backOperation:(UIButton *)sender;

- (IBAction)allClearButMemory:(UIButton *)sender;

- (IBAction)addOperation:(UIButton *)sender;

- (IBAction)addOperand:(UIButton *)sender;

- (IBAction)equalOperation:(UIButton *)sender;

- (void)displayResult:(NSNumber*) value;

- (void)resetTextToShow;

- (void) deallocResource;
@end

