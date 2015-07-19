//
//  OAuthViewController.m
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/2.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#define appkey @"1760970555"
#define appScret @"0c95f4a77482b557528ad9a35223951c"

#define authUrl @"https://api.weibo.com/oauth2/authorize"
#define responseType @"code"
#define redirectUrl @"https://api.weibo.com/oauth2/default.html"

#import "OAuthViewController.h"
#import "User.h"

@interface OAuthViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user=[[User alloc]init];
    weibo=[Weibo getInstance];
    [self.webView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"QQQQQQQQQQQQQQQQQ");
    NSString *url=[NSString stringWithFormat:@"%@?display=mobile&scope=all&client_id=%@&redirect_uri=%@&response_type=%@",authUrl,appkey,redirectUrl,responseType];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    
    [self.webView loadRequest:request];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *url = webView.request.URL.absoluteString;
//    NSLog(@"%@",url);
    
    if([url hasPrefix:@"https://api.weibo.com/oauth2/default.html?code="]){
        _code=[url substringFromIndex:47];
//        NSLog(@"%@",_accessToken);
   //     self.webView.hidden=YES;
        NSLog(@"%@",_code);
        NSString *l=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",appkey,appScret,redirectUrl,_code];
        NSURL *urlstring = [NSURL URLWithString:l];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:urlstring ];
        [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
        NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
        user.token=[dictionary objectForKey:@"access_token"];
        user.UID=[dictionary objectForKey:@"uid"];
        [dictionary writeToFile:weibo.finalPath atomically:YES];
        [self dismissModalViewControllerAnimated:YES];
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]) {
            [storage deleteCookie:cookie];
        }
//        NSLog(@"ACCESS %@  UID %@   %@",user.token,user.UID,weibo.finalPath);
    }
    
    
    
//    NSRange rang = NSMakeRange(52, 32);
//    _access_token = [url substringWithRange:rang];
//    //NSLog(@"access_token:%@",_access_token);
//    if([_access_token characterAtIndex:1] == '.')
//    {
//        //NSLog(@"OK");
//        [self.webView setHidden:YES];
//        [self performSegueWithIdentifier:@"show" sender:nil];
//    }
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
