//
//  HttpTool.m
//  HVeBo
//
//  Created by HJ on 14/12/10.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "HttpTool.h"
#import "UIImageView+WebCache.h"
#import "WBHttpRequest.h"
#import "AppDelegate.h"

@implementation HttpTool

+ (void)dowloadImage:(NSString *)url iamgeview:(UIImageView *)iamgeviewv placeHolder:(UIImage *)placeHolder
{
    if (placeHolder == nil) {
        placeHolder = [UIImage imageNamed:@"message_placeholder_picture.png"];
    }
    [iamgeviewv sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder options:SDWebImageRetryFailed|SDWebImageLowPriority];
}

//+(void)dowloadImageBig:(NSString *)url iamgeview:(UIImageView *)iamgeviewv placeHolder:(UIImage *)placeHolder
//{
//    if (placeHolder == nil) {
//        placeHolder = [UIImage imageNamed:@"message_placeholder_picture.png"];
//    }
//    [iamgeviewv sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder options:SDWebImageRetryFailed|SDWebImageLowPriority];
//}

+ (void)wbHttpRequest:(NSString *)url httpMethod:(NSString *)httpMethod params:(NSMutableDictionary *)params hander:(myBHttpRequest)hander
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (myDelegate.wbtoken != nil) {
        [params setObject:myDelegate.wbtoken forKey:@"access_token"];
    }
    
    [WBHttpRequest requestWithURL:[NSString stringWithFormat:@"%@%@",kSinaWeiboSDKAPIDomain,url] httpMethod:httpMethod params:params queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        hander(httpRequest, result, error);
    }];

//    [WBHttpRequest requestWithAccessToken:myDelegate.wbtoken url:[NSString stringWithFormat:@"%@%@",kSinaWeiboSDKAPIDomain,url] httpMethod:httpMethod params:params queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
//        hander(httpRequest, result, error);
//    }];
}


@end
