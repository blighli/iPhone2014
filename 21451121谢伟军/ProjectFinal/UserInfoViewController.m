//
//  UserInfoViewController.m
//  ProjectFinal
//
//  Created by xvxvxxx on 12/29/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController (){
    NetworkManager *networkManager;
}

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //给登陆图片添加手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginImageTapped)];
    [singleTap setNumberOfTapsRequired:1];
    self.loginImage.userInteractionEnabled = YES;
    [self.loginImage addGestureRecognizer:singleTap];
    
    //
    networkManager = [[NetworkManager alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginImageTapped{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (IBAction)logoutButtonTapped:(UIButton *)sender {
    
}
@end
