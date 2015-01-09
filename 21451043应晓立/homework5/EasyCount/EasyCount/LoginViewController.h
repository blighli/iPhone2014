//
//  LoginViewController.h
//  EasyCount
//
//  Created by yingxl1992 on 14/12/20.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "SlideNavigationController.h"

@interface LoginViewController : UIViewController<SlideNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UIButton *logBtn;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end