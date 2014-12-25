//
//  BaseWebViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/22.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>
{
    NSString *_url;
}
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *requset = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];

    [_webView loadRequest:requset];
    self.title = @"载入中...";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (id)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self != nil) {
        _url = [url copy];
    }
    return self;
}
- (IBAction)goBack:(UIBarButtonItem *)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}

- (IBAction)goForward:(UIBarButtonItem *)sender {
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}

- (IBAction)refresh:(UIBarButtonItem *)sender {
    [_webView reload];
}
@end
