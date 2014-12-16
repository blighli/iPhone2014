//
//  PostDetailVC.m
//  final
//
//  Created by xuyouyang on 14/12/15.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "PostDetailVC.h"

#import "UMSocial.h"

@interface PostDetailVC ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation PostDetailVC

- (void)viewDidLoad {
    // 设置社会分享工具栏
    CGSize size = [UIScreen mainScreen].bounds.size;
    size = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? size : CGSizeMake(size.height, size.width);
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:[self.post valueForKey:@"_id"]];
    socialData.shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。"; //分享内嵌文字
    socialData.shareImage = [UIImage imageNamed:@"UMS_social_demo"];//分享内嵌图片
    UMSocialBar *socialBar = [[UMSocialBar alloc] initWithUMSocialData:socialData withViewController:self];
    [socialBar.barButtons removeObjectAtIndex:2];
    //下面设置回调对象，如果你不需要得到回调方法也可以不设置
    socialBar.socialUIDelegate = self;
    socialBar.frame = CGRectMake(0, size.height - 43, size.width, 43);
    [self.view addSubview:socialBar];
    // 设置UIWebView
    self.webView.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:[self.post valueForKey:@"link"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareClick:(id)sender {
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"54904d42fd98c52186001569" shareText:@"你要分享的文字"shareImage:[UIImage imageNamed:@"icon.png"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]delegate:self];
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
