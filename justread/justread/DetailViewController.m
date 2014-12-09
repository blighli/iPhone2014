//
//  ViewController.m
//  justread
//
//  Created by Van on 14/12/3.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AAActivityAction.h"
#import "AAActivity.h"

@interface DetailViewController ()
@property (nonatomic) NSString * newsId;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *addfavoritesBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain  target:self action:@selector(addFavorites)];
    UIBarButtonItem *shareBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(tapShare)];
    self.navigationItem.rightBarButtonItems = @[shareBarButtonItem,addfavoritesBarButtonItem];
    if(nil != self.story){
        self.newsId = [self.story.id stringValue];
        NSLog(@"story  id is %@",self.newsId);
        NSString *urlPrefix = @"http://news-at.zhihu.com/api/3/news/";
        NSString *fullUrl = [urlPrefix stringByAppendingString:self.newsId];
        NSLog(@"full url is %@",fullUrl);
        NSURLSessionDataTask *task = [self getJsonFrom:fullUrl];
        [task resume];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addFavorites{
    
}

- (void) tapShare{
    UIImage *wechatImage = [UIImage imageNamed:@"wechat"];
    UIImage *momentsImage = [UIImage imageNamed:@"moments"];
    UIImage *weiboImage = [UIImage imageNamed:@"weibo"];
    UIImage *pocketImage = [UIImage imageNamed:@"pocket"];
    NSMutableArray *array = [NSMutableArray array];
    AAActivity *wechatActivity = [[AAActivity alloc] initWithTitle:@"微信"
                                                       image:wechatImage
                                                 actionBlock:^(AAActivity *activity, NSArray *activityItems) {
                                                     NSLog(@"doing activity = %@, activityItems = %@", activity, activityItems);

                                                 }];
    [array addObject:wechatActivity];
    AAActivity *momentsActivity = [[AAActivity alloc] initWithTitle:@"朋友圈"
                                                            image:momentsImage
                                                      actionBlock:^(AAActivity *activity, NSArray *activityItems) {
                                                          NSLog(@"doing activity = %@, activityItems = %@", activity, activityItems);
                                                          
                                                      }];
    
    [array addObject:momentsActivity];
    AAActivity *weiboActivity = [[AAActivity alloc] initWithTitle:@"微博"
                                                              image:weiboImage
                                                        actionBlock:^(AAActivity *activity, NSArray *activityItems) {
                                                            NSLog(@"doing activity = %@, activityItems = %@", activity, activityItems);
                                                            
                                                        }];
    
    [array addObject:weiboActivity];
    AAActivity *pocketActivity = [[AAActivity alloc] initWithTitle:@"Pocket"
                                                              image:pocketImage
                                                        actionBlock:^(AAActivity *activity, NSArray *activityItems) {
                                                            NSLog(@"doing activity = %@, activityItems = %@", activity, activityItems);
                                                            
                                                        }];
    
    [array addObject:pocketActivity];
    AAActivityAction *aaShare = [[AAActivityAction alloc] initWithActivityItems:@[]
                                                     applicationActivities:array
                                                                 imageSize:AAImageSizeNormal];
    
    aaShare.title = @"分享到";
    //aa.directActionEnabled = YES;
    [aaShare show];
}
-(NSURLSessionDataTask *) getJsonFrom:(NSString *)Url{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:Url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            NSDictionary *json = (NSDictionary *)responseObject;
            NSString *htmlPreFix = @"<!doctype html><html>";
            NSString *htmlSuffFix = @"</html>";
            NSString *headPreFix = @"<head>";
            NSString *cssPreFix = @"<style type='text/css'>";
            NSString *cssSufFix = @"</style>";
            NSString *headSuffFix = @"</head>";
            NSString *insertImgScript;
            if ([json isKindOfClass:[NSDictionary class]]){
                NSString *body = [[@"<body>" stringByAppendingString:[json objectForKey:@"body"]] stringByAppendingString:@"</body>"];
                NSString *imageSrc = [json objectForKey:@"image"];
                NSString *title = [json objectForKey:@"title"];
                NSString *imageSource = [json objectForKey:@"image_source"];
                if(imageSrc){
                        insertImgScript = [NSString stringWithFormat:@"<script type='text/javascript'>window.onload = function(){var elem = document.createElement('img');elem.setAttribute('src', '%@');        elem.setAttribute('style', 'max-width: 100%;vertical-align:middle;margin-top: -100px;');var div = document.getElementsByClassName('img-place-holder')[0];div.style.overflow = 'hidden';div.appendChild(elem);var h2 = document.createElement('h2');h2.innerHTML='%@';h2.style.position = 'absolute';h2.style.top = '100px';h2.style.width = '100%'; h2.style.color ='white';h2.style.font = '22px Helvetica, Sans-Serif';h2.style.paddingRight = '8px';h2.style.paddingLeft = '8px';div.appendChild(h2); var h7 = document.createElement('h7');h7.innerHTML='图片: %@';h7.style.position = 'absolute';h7.style.top = '170px';h7.style.maxWidth = '100%';h7.style.color ='white';h7.style.paddingRight = '8px'; h7.style.paddingBottom ='18px';h7.style.right = '8px';h7.style.font = '10px Helvetica-Light, Sans-Serif';div.appendChild(h7);}</script>",imageSrc,title,imageSource];
                }
                NSArray *csss = [json objectForKey:@"css"];
                NSString *css = csss[0];
                NSData *cssData = [NSData dataWithContentsOfURL:[NSURL URLWithString:css]];
                NSString *cssString = [[NSString alloc] initWithData:cssData encoding:NSUTF8StringEncoding];
                NSString *pageContent = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",
                 htmlPreFix,headPreFix,insertImgScript,cssPreFix,cssString,cssSufFix,headSuffFix,body,htmlSuffFix];
                NSLog(@"html is %@",pageContent);
                [self.webView loadHTMLString:pageContent baseURL:nil];
                
            }
        }
    }];
    
    return task;
}
@end
