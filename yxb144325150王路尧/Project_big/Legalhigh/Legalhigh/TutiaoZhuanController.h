//
//  TutiaoZhuanController.h
//  Legalhigh
//
//  Created by 王路尧 on 14/12/10.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIDViewController.h"
#import "TupianBianji.h"

@interface TutiaoZhuanController : UIViewController

@property (strong, nonatomic) BIDViewController *YellowViewController;
@property (strong, nonatomic) TupianBianji *BlueViewController;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (strong, nonatomic) UIImage *image;

- (IBAction)backPressed:(id)sender;

@end