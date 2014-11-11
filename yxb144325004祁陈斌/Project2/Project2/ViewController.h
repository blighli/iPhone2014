//
//  ViewController.h
//  Project2
//
//  Created by xsdlr on 14/11/3.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic,strong) IBOutlet UITextField* outputTextField;

@property(nonatomic,strong) IBOutlet UILabel* memoryLabel;

- (IBAction) buttonPress:(UIButton *)sender;

@end

