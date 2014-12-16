//
//  PostDetailVC.m
//  final
//
//  Created by xuyouyang on 14/12/15.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "PostDetailVC.h"

@interface PostDetailVC ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation PostDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:self.postUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
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
