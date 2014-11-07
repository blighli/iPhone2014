//
//  ViewController.h
//  Calculator
//
//  Created by Mz on 14-11-3.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *screen;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;

@property BOOL showingResult;
@property double memoryValue;

- (IBAction)buttonClear:(id)sender;
- (IBAction)buttonInput:(id)sender;
- (IBAction)buttonResult:(id)sender;
- (IBAction)buttonMemory:(id)sender;

@end
