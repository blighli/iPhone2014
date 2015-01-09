//
//  RegViewController.m
//  EasyCount
//
//  Created by yingxl1992 on 14/12/21.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "RegViewController.h"

@interface RegViewController ()

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *leftuserimage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user.png"]];
    _usernameTextField.leftView=leftuserimage;
    _usernameTextField.leftView.backgroundColor=[UIColor lightGrayColor];
    _usernameTextField.leftViewMode=UITextFieldViewModeAlways;
    
    UIImageView *leftpwdimage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd.png"]];
    _pwdTextField.leftView=leftpwdimage;
    _pwdTextField.leftView.backgroundColor=[UIColor lightGrayColor];
    _pwdTextField.leftViewMode=UITextFieldViewModeAlways;
    
    [_regBtn addTarget:self action:@selector(reg) forControlEvents:1];
}

- (void)reg {
    NSString *username=_usernameTextField.text;
    NSString *pwd=_pwdTextField.text;
    
    //发送post请求调用ws
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/reg"];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    NSString *paramstr=[NSString stringWithFormat:@"username=%@&&password=%@",username,pwd];
    NSData *params=[paramstr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:params];
    
    NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *resstr=[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSInteger res=[resstr integerValue];
   
    if (res==1) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功，请登录~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    } else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败，请重试~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [self performSegueWithIdentifier:@"toLogSegue" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
