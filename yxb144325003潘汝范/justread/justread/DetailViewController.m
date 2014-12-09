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
#import "WechatViewController.h"
#import "UIView+Toast.h"
#import "FavStories.h"

@interface DetailViewController ()
@property (nonatomic) NSString *newsId;
@property (nonatomic) NSString *shareUrl;
@property (nonatomic) NSString *newsTitle;
@property (nonatomic) UIBarButtonItem *addfavoritesBarButtonItem;
@property NSManagedObjectContext *managedObjectContext;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    if (self.isFaved) {
        self.addfavoritesBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ufavorites"] style:UIBarButtonItemStylePlain  target:self action:@selector(addFavorites)];
    }else{
        self.addfavoritesBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorites"] style:UIBarButtonItemStylePlain  target:self action:@selector(addFavorites)];
    }    
    UIBarButtonItem *shareBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(tapShare)];
    self.navigationItem.rightBarButtonItems = @[shareBarButtonItem,self.addfavoritesBarButtonItem];
    if(nil != self.story){
        self.newsId = [self.story.id stringValue];
        NSLog(@"story  id is %@",self.newsId);
        NSString *urlPrefix = @"http://news-at.zhihu.com/api/3/news/";
        NSString *fullUrl = [urlPrefix stringByAppendingString:self.newsId];
        NSLog(@"full url is %@",fullUrl);
        NSURLSessionDataTask *task = [self getJsonFrom:fullUrl];
        [task resume];
        [self serachWith:self.story];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addFavorites{

    if(self.isFaved){
        self.addfavoritesBarButtonItem.image = [UIImage imageNamed:@"favorites"];
        [self.view makeToast:@"取消收藏"];
        self.isFaved = NO;
    }else{
        self.addfavoritesBarButtonItem.image = [UIImage imageNamed:@"ufavorites"];
        [self.view makeToast:@"收藏成功"];
        self.isFaved = YES;
    }
    if(self.managedObjectContext != nil){

        if (!self.isFaved) {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:[NSEntityDescription entityForName:@"FavStories"inManagedObjectContext:self.managedObjectContext]];
            NSNumber *id = self.story.id;
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id==%@", id]];
            NSError* error = nil;
            NSArray* results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            if ([results count] > 0) {
                [self.managedObjectContext deleteObject:[results objectAtIndex:0]];
                NSLog(@"删除的数据 %@",[results objectAtIndex:0]);
            }

            NSError *derror;
            [self.managedObjectContext save:&derror];
        }else{
            FavStories *fStory = (FavStories *)[NSEntityDescription insertNewObjectForEntityForName:@"FavStories" inManagedObjectContext:self.managedObjectContext];
            [fStory setId:self.story.id];
            [fStory setType:self.story.type];
            [fStory setGa_prefix:self.story.ga_prefix];
            [fStory setDate:self.story.date];
            [fStory setShare_url:self.story.share_url];
            if ([self.story.images count]>0) {
                [fStory setImages:self.story.images[0]];
            }
            [fStory setTitle:self.story.title];
            NSError *error;
            [self.managedObjectContext save:&error];

        }
    }

}

- (void) tapShare{
    UIImage *wechatImage = [UIImage imageNamed:@"wechat"];
    UIImage *momentsImage = [UIImage imageNamed:@"moments"];
    UIImage *weiboImage = [UIImage imageNamed:@"weibo"];
    UIImage *pocketImage = [UIImage imageNamed:@"pocket"];
    NSMutableArray *array = [NSMutableArray array];
    WechatViewController *wechatVC =[[WechatViewController alloc] init];
    AAActivity *wechatActivity = [[AAActivity alloc] initWithTitle:@"微信"
                                                       image:wechatImage
                                                 actionBlock:^(AAActivity *activity, NSArray *activityItems) {
                                                     NSLog(@"doing activity = %@, activityItems = %@", activity, activityItems);
                                                     if([wechatVC shareToWechatwith:self.title with:self.title with:self.shareUrl with:NO]){
                                                         
                                                     }else{
                                                         [self showAlertWith:@"请安装最新版本微信"];
                                                         NSLog(@"分享出错");
                                                     }

                                                 }];
    [array addObject:wechatActivity];
    AAActivity *momentsActivity = [[AAActivity alloc] initWithTitle:@"朋友圈"
                                                            image:momentsImage
                                                      actionBlock:^(AAActivity *activity, NSArray *activityItems) {
                                                          NSLog(@"doing activity = %@, activityItems = %@", activity, activityItems);
                                                          if([wechatVC shareToWechatwith:self.title with:self.title with:self.shareUrl with:YES]){
                                                              
                                                          }else{
                                                              [self showAlertWith:@"请安装最新版本微信"];
                                                          }
                                                          
                                                      }];
    
    [array addObject:momentsActivity];
    AAActivity *weiboActivity = [[AAActivity alloc] initWithTitle:@"微博"
                                                              image:weiboImage
                                                        actionBlock:^(AAActivity *activity, NSArray *activityItems) {
                                                            NSLog(@"doing activity = %@, activityItems = %@", activity, activityItems);
                                                            [self showAlertWith:@"分享到微博功能正在开发中"];
                                                        }];
    
    [array addObject:weiboActivity];
    AAActivity *pocketActivity = [[AAActivity alloc] initWithTitle:@"Pocket"
                                                              image:pocketImage
                                                        actionBlock:^(AAActivity *activity, NSArray *activityItems) {
                                                            [self showAlertWith:@"分享到Pocket功能正在开发中"];
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
            NSString *insertDayImgScript;
            NSString *insertNightImgScript;
            if ([json isKindOfClass:[NSDictionary class]]){
                NSString *body = [[@"<body>" stringByAppendingString:[json objectForKey:@"body"]] stringByAppendingString:@"</body>"];
                NSString *imageSrc = [json objectForKey:@"image"];
                NSString *title = [json objectForKey:@"title"];
                self.newsTitle = title;
                self.shareUrl = [json objectForKey:@"share_url"];
                NSString *imageSource = [json objectForKey:@"image_source"];
                if(imageSrc){
                        insertDayImgScript = [NSString stringWithFormat:@"<script type='text/javascript'>window.onload = function(){var elem = document.createElement('img');elem.setAttribute('src', '%@');        elem.setAttribute('style', 'max-width: 100%;vertical-align:middle;margin-top: -100px;');var div = document.getElementsByClassName('img-place-holder')[0];div.style.overflow = 'hidden';div.appendChild(elem);var h2 = document.createElement('h2');h2.innerHTML='%@';h2.style.position = 'absolute';h2.style.top = '100px';h2.style.width = '100%'; h2.style.color ='white';h2.style.font = '22px Helvetica, Sans-Serif';h2.style.paddingRight = '8px';h2.style.paddingLeft = '8px';div.appendChild(h2); var h7 = document.createElement('h7');h7.innerHTML='图片: %@';h7.style.position = 'absolute';h7.style.top = '170px';h7.style.maxWidth = '100%';h7.style.color ='white';h7.style.paddingRight = '8px'; h7.style.paddingBottom ='18px';h7.style.right = '8px';h7.style.font = '10px Helvetica-Light, Sans-Serif';div.appendChild(h7);}</script>",imageSrc,title,imageSource];
                        insertNightImgScript = [NSString stringWithFormat:@"<script type='text/javascript'>window.onload = function(){var elem = document.createElement('img');elem.setAttribute('src', '%@');        elem.setAttribute('style', 'max-width: 100%;vertical-align:middle;margin-top: -100px;');var div = document.getElementsByClassName('img-place-holder')[0];div.style.overflow = 'hidden';div.appendChild(elem);var h2 = document.createElement('h2');h2.innerHTML='%@';h2.style.position = 'absolute';h2.style.top = '100px';h2.style.width = '100%'; h2.style.color ='white';h2.style.font = '22px Helvetica, Sans-Serif';h2.style.paddingRight = '8px';h2.style.paddingLeft = '8px';div.appendChild(h2); var h7 = document.createElement('h7');h7.innerHTML='图片: %@';h7.style.position = 'absolute';h7.style.top = '170px';h7.style.maxWidth = '100%';h7.style.color ='white';h7.style.paddingRight = '8px'; h7.style.paddingBottom ='18px';h7.style.right = '8px';h7.style.font = '10px Helvetica-Light, Sans-Serif';div.appendChild(h7);document.body.className = 'night';}</script>",imageSrc,title,imageSource];
                }else{
                    insertDayImgScript = @"<script type='text/javascript'>window.onload = function(){}</script>";
                    insertNightImgScript = @"<script type='text/javascript'>window.onload = function(){document.body.className = 'night';}</script>";
                }
                NSArray *csss = [json objectForKey:@"css"];
                NSString *css = csss[0];
                NSData *cssData = [NSData dataWithContentsOfURL:[NSURL URLWithString:css]];
                NSString *cssString = [[NSString alloc] initWithData:cssData encoding:NSUTF8StringEncoding];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                if([userDefaults boolForKey:@"night"]){
                    NSLog(@"at night is %@",[userDefaults objectForKey:@"night"]);
                    NSString *pageContent = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",
                                             htmlPreFix,headPreFix,cssPreFix,cssString,cssSufFix,insertNightImgScript,headSuffFix,body,htmlSuffFix];
                    [self.webView loadHTMLString:pageContent baseURL:nil];
                }else{
                    
                    NSString *pageContent = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",
                                             htmlPreFix,headPreFix,cssPreFix,cssString,cssSufFix,insertDayImgScript,headSuffFix,body,htmlSuffFix];
                     NSLog(@"html is %@",pageContent);
                    [self.webView loadHTMLString:pageContent baseURL:nil];
                }

                
                
            }
        }
    }];
    
    return task;
}
- (void) showAlertWith:(NSString *)message{
    if ([UIAlertController class])
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];        
        [alert show];
        
    }
}

- (void) serachWith:(Stories *) stories{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"FavStories"inManagedObjectContext:self.managedObjectContext]];
    NSNumber *id = stories.id;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id==%@", id]];
    NSError* error = nil;
    NSArray* results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([results count] > 0) {
         self.addfavoritesBarButtonItem.image = [UIImage imageNamed:@"ufavorites"];
    }else{
         self.addfavoritesBarButtonItem.image = [UIImage imageNamed:@"favorites"];
    }

}
@end
