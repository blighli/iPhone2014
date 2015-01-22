//
//  UpdatePwdViewController.m
//  EasyCount
//
//  Created by yingxl1992 on 15/1/8.
//  Copyright (c) 2015年 21451043应晓立. All rights reserved.
//

#import "UpdatePwdViewController.h"

@interface UpdatePwdViewController ()

@end

@implementation UpdatePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_confirmBtn addTarget:self action:@selector(updatePwd) forControlEvents:1];
    [_cancelBtn addTarget:self action:@selector(cancelOper) forControlEvents:1];
}

- (void)updatePwd {
    NSUserDefaults *userInfo=[NSUserDefaults standardUserDefaults];
    NSString *oldpwd1=[userInfo valueForKey:@"pwd"];
    NSString *oldpwd2=[_oldPwdText text];
    if ([oldpwd1 compare:oldpwd2]!=NSOrderedSame) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"密码不正确，请重试~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    } else {
        NSString *newpwd1=[_pwdText1 text];
        NSString *newpwd2=[_pwdText2 text];
        if ([newpwd1 compare:newpwd2]==NSOrderedSame) {
            NSURL *url=[NSURL URLWithString:@"http://localhost:8080/updatePwd"];
            NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
            [request setHTTPMethod:@"POST"];
            NSString *paramstr=[NSString stringWithFormat:@"username=%@&&password=%@",[userInfo valueForKey:@"username"],newpwd1];
            NSData *params=[paramstr dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:params];
            
            NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSString *res=[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
            
            if ([res compare:@"1"]==NSOrderedSame) {
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功~" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            } else {
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"修改失败，请重试~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
            }

        } else {
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"两次输入密码不一致，请重试~" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [self dismissViewControllerAnimated: YES completion: nil ];
    }
}

- (void)cancelOper {
    [self dismissViewControllerAnimated: YES completion: nil ];
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
