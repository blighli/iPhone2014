//
//  ViewController.h
//  calculator
//
//  Created by apple on 14/11/6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *displaylabel;
- (IBAction)operators:(id)sender;

- (IBAction)NumberPress:(id)sender;
- (void)deleteprestring:(NSString*)str;
- (NSDecimalNumber*)calculatebyoper:(int)option;
- (IBAction)clearAll:(id)sender;
- (IBAction)calReslut:(id)sender;
- (IBAction)deleteNum:(id)sender;
- (IBAction)dotPress:(id)sender;
- (IBAction)memClear:(id)sender;
- (IBAction)memInput:(id)sender;
- (IBAction)memShow:(id)sender;


@end

