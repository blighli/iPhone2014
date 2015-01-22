//
//  UpdatePwdViewController.h
//  EasyCount
//
//  Created by yingxl1992 on 15/1/8.
//  Copyright (c) 2015年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePwdViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldPwdText;
@property (weak, nonatomic) IBOutlet UITextField *pwdText1;
@property (weak, nonatomic) IBOutlet UITextField *pwdText2;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end
