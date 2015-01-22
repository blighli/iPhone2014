//
//  LoginViewController.m
//  EasyCount
//
//  Created by yingxl1992 on 14/12/20.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu {
    return NO;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *leftuserimage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user.png"]];
    _userTextField.leftView=leftuserimage;
    _userTextField.leftView.backgroundColor=[UIColor lightGrayColor];
    _userTextField.leftViewMode=UITextFieldViewModeAlways;
    
    UIImageView *leftpwdimage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd.png"]];
    _pwdTextField.leftView=leftpwdimage;
    _pwdTextField.leftView.backgroundColor=[UIColor lightGrayColor];
    _pwdTextField.leftViewMode=UITextFieldViewModeAlways;
    
    [_logBtn addTarget:self action:@selector(login) forControlEvents:1];
    
}

- (void)login {
    NSString *username=_userTextField.text;
    NSString *pwd=_pwdTextField.text;
    
//    发送post请求调用ws
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/log"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    NSString *paramstr=[NSString stringWithFormat:@"username=%@",username];
    NSData *params=[paramstr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:params];
    
    NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *realpwd=[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"%@",realpwd);
    
    if ([pwd compare:realpwd]==NSOrderedSame) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        NSUserDefaults *userInfo=[NSUserDefaults standardUserDefaults];
        [userInfo setObject:_userTextField.text forKey:@"username"];
        [userInfo setObject:pwd forKey:@"pwd"];
    } else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录失败，请重试~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier compare:@"loginSegue"]==NSOrderedSame) {
        MainViewController *destViewController=segue.destinationViewController;
        NSString *username=_userTextField.text;
        [destViewController setUsername:username];
    }
}

@end
