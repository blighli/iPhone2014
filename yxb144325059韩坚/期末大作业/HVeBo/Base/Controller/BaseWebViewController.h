//
//  BaseWebViewController.h
//  HVeBo
//
//  Created by HJ on 14/12/22.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)goBack:(UIBarButtonItem *)sender;
- (IBAction)goForward:(UIBarButtonItem *)sender;
- (IBAction)refresh:(UIBarButtonItem *)sender;

- (id)initWithUrl:(NSString *)url;

@end
