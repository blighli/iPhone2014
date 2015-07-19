//
//  WBLoginViewController.m
//  weiBo
//
//  Created by lixu on 15/1/3.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import "WBLoginViewController.h"

#define kAppKey        @"4001696098"
#define kRederectUri   @"https://api.weibo.com/oauth2/default.html"
#define kAppSecret     @"b619afc323f22ed7852e4cd057831f93"

@interface WBLoginViewController ()

@end

@implementation WBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"__________");
//    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSString *documentsD=[path objectAtIndex:0];
//    NSString *userFile=[documentsD stringByAppendingString:@"User.plist"];
//    NSMutableDictionary *userD=[[NSMutableDictionary alloc] initWithContentsOfFile:userFile];
//    NSString* token=[userD objectForKey:@"token"];
//    if (token) {
//        [self performSegueWithIdentifier:@"toMainView" sender:nil];
//        return;
//    }
    NSString *string=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code",kAppKey,kRederectUri];
    NSURL *URL=[NSURL URLWithString:string];
    NSURLRequest *request=[NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [_loginWebView loadRequest:request];
    NSLog(@"++++++++++++++");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
-(void) webViewDidFinishLoad:(UIWebView *)webView{
    NSString *rpURL=webView.request.URL.absoluteString;
    NSLog(@"%@",rpURL);
    if ([rpURL hasPrefix:@"https://api.weibo.com/oauth2/default.html?code="]) {
        NSString* code=[rpURL substringFromIndex:47];
        NSString *string=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",kAppKey,kAppSecret,code,kRederectUri];
        NSURL *url=[NSURL URLWithString:string];
        
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
        request.HTTPMethod=@"POST";
        NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
        
        extern NSString* _token;
        NSString* token=[dictionary objectForKey:@"access_token"];
        NSString* userID=[dictionary objectForKey:@"uid"];
        
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString* documentsD=[path objectAtIndex:0];
        NSString * configFile=[documentsD stringByAppendingString:@"User.plist"];
        
        NSMutableDictionary* configList=[[NSMutableDictionary alloc] initWithObjectsAndKeys:token,@"token",userID,@"uid", nil];
        [configList writeToFile:configFile atomically:YES];
        [self performSegueWithIdentifier:@"toMainView" sender:nil];
        
        NSLog(@"data数据：%@\n这是token：%@\n这是userid：%@\n",dictionary,token,userID);
        
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
}


@end
