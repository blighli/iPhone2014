//
//  ViewController.h
//  Calculator
//
//  Created by 陈晟豪 on 14/11/3.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *outLabel;
@property (weak, nonatomic) IBOutlet UIButton *mcButton;
@property (weak, nonatomic) IBOutlet UIButton *maButton;
@property (weak, nonatomic) IBOutlet UIButton *mmButton;
@property (weak, nonatomic) IBOutlet UIButton *mrButton;
@property (weak, nonatomic) IBOutlet UIButton *delButton;
@property (weak, nonatomic) IBOutlet UIButton *lbButton;
@property (weak, nonatomic) IBOutlet UIButton *rbButton;
@property (weak, nonatomic) IBOutlet UIButton *perButton;
@property (weak, nonatomic) IBOutlet UIButton *acButton;
@property (weak, nonatomic) IBOutlet UIButton *divButton;
@property (weak, nonatomic) IBOutlet UIButton *mulButton;
@property (weak, nonatomic) IBOutlet UIButton *minButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *pmButton;
@property (weak, nonatomic) IBOutlet UIButton *equButton;
@property (weak, nonatomic) IBOutlet UIButton *decButton;
@property (weak, nonatomic) IBOutlet UIButton *zeroButton;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *thrButton;
@property (weak, nonatomic) IBOutlet UIButton *fouButton;
@property (weak, nonatomic) IBOutlet UIButton *fivButton;
@property (weak, nonatomic) IBOutlet UIButton *sixButton;
@property (weak, nonatomic) IBOutlet UIButton *sevButton;
@property (weak, nonatomic) IBOutlet UIButton *eigButton;
@property (weak, nonatomic) IBOutlet UIButton *ninButton;

- (IBAction)pressButton:(id)sender;
@end

