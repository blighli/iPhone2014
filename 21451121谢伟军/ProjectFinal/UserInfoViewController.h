//
//  UserInfoViewController.h
//  ProjectFinal
//
//  Created by xvxvxxx on 12/29/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "NetworkManager.h"
@interface UserInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *loginImage;
- (IBAction)logoutButtonTapped:(UIButton *)sender;

@end
