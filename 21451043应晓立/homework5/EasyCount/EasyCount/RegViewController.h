//
//  RegViewController.h
//  EasyCount
//
//  Created by yingxl1992 on 14/12/21.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *regBtn;

@end
