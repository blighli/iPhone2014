//
//  ViewController.h
//  Calculator
//
//  Created by Mac on 14-11-7.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

 


@interface ViewController : UIViewController
{
@private
  
    int errorCode;
}
@property(nonatomic,strong) NSString *memory ;

- (IBAction)numberButtonPressed:(UIButton *)sender;

- (IBAction)OperatorButtonPressed:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UITextField *resultText;

- (IBAction)MRButtonPressed:(UIButton *)sender;

- (IBAction)MPlusButtonPressed:(UIButton *)sender;

- (IBAction)MSubButtonPressed:(UIButton *)sender;

- (IBAction)MemClearButtonPressed:(UIButton *)sender;

- (IBAction)clearButtonPressed:(UIButton *)sender;

- (IBAction)EqualButtonPressed:(id)sender;


@end
