//
//  XLAccountViewController.m
//  XinLang
//
//  Created by 周舟 on 14-9-30.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLAccountViewController.h"
#import "XLAccount.h"
#import "XLHttpTool.h"
#import "XLAccountTool.h"
#import "MBProgressHUD.h"
#import "XLTabBarViewController.h"
#import "MBProgressHUD+MJ.h"

@interface XLAccountViewController ()<UIWebViewDelegate>

@end

@implementation XLAccountViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //2.加载授权页面（登陆界面）
    NSURL *url = [NSURL URLWithString:XLLoginURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
    
}

#pragma UIWebViewDelegate 代理方法
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载"];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //NSLog(@"--shouldStartLoadWithRequest--request:%@",request);
    NSString *urlStr = request.URL.absoluteString;
    
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        int loc = range.location + range.length;
        
        NSString *code = [urlStr substringFromIndex:loc];
        //NSLog(@"--shouldStartLoadWithRequest--code:%@",code);
        
        [self accessTokenWithCode:code];
        return NO;
        
    }
    
    return YES;
    
}

- (void)accessTokenWithCode:(NSString *)code
{
    //1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = XLAppKey;
    params[@"client_secret"] = XLAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = XLRedirectURI;
    NSString *urlString = @"https://api.weibo.com/oauth2/access_token";
    //2.发送post请求
    [XLHttpTool postWithURL:urlString params:params success:^(id json) {
        //NSLog(@"---accessTokenWithCode--json:%@",json);
        XLAccount *account = [XLAccount accountWithDict:json];
        [XLAccountTool saveAccount:account];
        
        [XLAccountTool account];
        
        
        self.view.window.rootViewController = [[XLTabBarViewController alloc] init];
    } failure:^(NSError *error) {
        NSLog(@"--accessTokenWithCode--error:%@",error);
        
    }];
    
}

@end
