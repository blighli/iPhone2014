//
//  LoginViewController.m
//  ProjectFinal
//
//  Created by xvxvxxx on 12/27/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkManager.h"
#import <UIKit+AFNetworking.h>
@interface LoginViewController (){
    NSMutableString *captchaID;
    NetworkManager *networkManager;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    networkManager = [[NetworkManager alloc]init];
    networkManager.CaptchaImageDelegate = self;
    [self loadCaptchaImage];
    //初始化图片点击事件
    self.captchaImageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadCaptchaImage)];
    
        [singleTap setNumberOfTapsRequired:1];
        [self.captchaImageview addGestureRecognizer:singleTap];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCaptchaImageWithURLInString:(NSString *)url{
    [self.captchaImageview setImageWithURL:[NSURL URLWithString:url]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)submitButton:(UIButton *)sender{
    NSString *username = _username.text;
    NSString *password = _password.text;
    NSString *captcha = _captcha.text;
    [networkManager LoginwithUsername:username Password:password Captcha:captcha RememberOnorOff:@"off"];
}

//验证码图片点击刷新验证码事件
-(void)loadCaptchaImage{
    [networkManager loadCaptchaImage];
}
@end
