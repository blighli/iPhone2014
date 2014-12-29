//
//  BaseCell.m
//  HVeBo
//
//  Created by HJ on 14/12/18.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseCell.h"
#import "IconView.h"
#import "MDHTMLLabel.h"
#import "RegexKitLite.h"
#import "NSString+URLEncoding.h"
#import "UserViewController.h"
#import "WBNavigationController.h"
#import "BaseWebViewController.h"

@interface BaseCell()

@end

@implementation BaseCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addMySuabViews];
    }
    return self;
}
- (void)settingBg
{
    UIImageView *bg = [[UIImageView alloc] init];
    self.backgroundView = bg;
    _bg = bg;
    
    UIImageView *seletcedBg = [[UIImageView alloc] init];
    self.selectedBackgroundView = seletcedBg;
    _selectedBg = seletcedBg;
}

- (void)addMySuabViews
{
    // 1.头像
    _icon = [[IconView alloc]init];
    [self.contentView addSubview:_icon];
    
    // 2.昵称
    _screenName = [[UILabel alloc] init];
    _screenName.font = kScreenNameFont;
    _screenName.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_screenName];
    
    // 皇冠图标
    _mbIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership.png"]];
    [self.contentView addSubview:_mbIcon];
    
    // 3.时间
    _time = [[UILabel alloc] init];
    _time.font = kTimeFont;
    _time.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_time];
    
    // 4.内容
    _text = [[MDHTMLLabel alloc] init];
    _text.numberOfLines = 0;
    _text.font = kTextFont;
    _text.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_text];
    
}
#pragma mark - 解析超链接
- (NSString *)parseLink:(NSString *)text
{
    //正则表达式
    NSString *regex = @"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
    NSArray *matchArray = [text componentsMatchedByRegex:regex];
    for (NSString *linkString in matchArray) {
        //<a href='user://@用户'>@用户</a>
        //<a href='http://baidu.com'>http://baidu.com</a>
        //<a href='topic://#话题#'>#话题#</a>
        
        NSString *replacing = nil;
        if ([linkString hasPrefix:@"@"]) {
            replacing = [NSString stringWithFormat:@"<a href='user://%@'>%@</a>",[linkString URLEncodedString],linkString];
        }else if([linkString hasPrefix:@"http"]){
            replacing = [NSString stringWithFormat:@"<a href='http://%@'>%@</a>",[linkString URLEncodedString],linkString];
        }else if([linkString hasPrefix:@"#"]){
            replacing = [NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",[linkString URLEncodedString],linkString];
        }
        if (replacing != nil) {
            text = [text stringByReplacingOccurrencesOfString:linkString withString:replacing];
        }
    }
    return text;
}
#pragma mark - MDHTMLLabelDelegate methods

- (void)HTMLLabel:(MDHTMLLabel *)label didSelectLinkWithURL:(NSURL *)URL
{
   // NSLog(@"Did select link with URL: %@", URL.absoluteString);
    WBNavigationController *nav = [[WBNavigationController alloc] init];
    if ([URL.absoluteString hasPrefix:@"user"]) {
        UserViewController *user = [[UserViewController alloc] init];
        [nav addChildViewController:user];
        user.userName = [[URL.host URLDecodedString] substringFromIndex:1];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }
    if ([URL.absoluteString hasPrefix:@"http"]) {
        BaseWebViewController *web = [[BaseWebViewController alloc] initWithUrl:[URL.host URLDecodedString]];
        [nav addChildViewController:web];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }
    
}

- (void)HTMLLabel:(MDHTMLLabel *)label didHoldLinkWithURL:(NSURL *)URL
{
    WBNavigationController *nav = [[WBNavigationController alloc] init];
    if ([URL.absoluteString hasPrefix:@"user"]) {
        UserViewController *user = [[UserViewController alloc] init];
        [nav addChildViewController:user];
        user.userName = [[URL.host URLDecodedString] substringFromIndex:1];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }
    if ([URL.absoluteString hasPrefix:@"http"]) {
        BaseWebViewController *web = [[BaseWebViewController alloc] initWithUrl:[URL.host URLDecodedString]];
        [nav addChildViewController:web];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }
}
@end
