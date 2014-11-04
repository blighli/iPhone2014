//
//  ViewController.h
//  Calculator
//
//  Created by Mz on 14-11-3.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)buttonClear:(id)sender;
- (IBAction)buttonInput:(id)sender;
- (IBAction)buttonResult:(id)sender;

@end
