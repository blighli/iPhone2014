//
//  XLReweetStatusView.m
//  XinLang
//
//  Created by 周舟 on 14-10-3.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLReweetStatusView.h"
#import "XLStatus.h"
#import "XLBaseStatusFrame.h"
#import "XLPhotosView.h"
#import "XLPhoto.h"
#import "XLUser.h"
#import "XLDetailViewController.h"
#import "XLNavationViewController.h"
#import "XLTabBarViewController.h"

@interface XLReweetStatusView()

/**
 *  被转发微博昵称
 */
@property (nonatomic, weak) UILabel *retNameLabel;

/**
 *  被转发微博内容
 */
@property (nonatomic, weak) UILabel *retContentLabel;
/**
 *   被转发微博微博配图
 */
@property (nonatomic, weak) XLPhotosView *retPhotoViews;


@end

@implementation XLReweetStatusView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = XLColor(245, 244, 244);
        //1.昵称
        UILabel *retNameLabel = [[UILabel alloc] init];
        retNameLabel.font = XLRetweetStatusNameFont;
        retNameLabel.textColor = XLColor(67, 107, 163);
        retNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:retNameLabel];
        self.retNameLabel = retNameLabel;
        
        //2.正文
        UILabel *retContentLabel = [[UILabel alloc] init];
        retContentLabel.font = XLRetweetStatusContentFont;
        retContentLabel.textColor = XLColor(90, 90, 90);
        retContentLabel.numberOfLines = 0;
        retContentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:retContentLabel];
        self.retContentLabel = retContentLabel;
        
        //3.添加配图
        XLPhotosView *retPhotoViews = [[XLPhotosView alloc] init];
        retPhotoViews.hidden = YES;
        [self addSubview:retPhotoViews];
        self.retPhotoViews = retPhotoViews;
        //4.添加点击事件
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweet)];
        
        [self addGestureRecognizer:recognizer];

        
    }
    return self;
}

- (void)showRetweet
{
    XLStatus *retStatus = self.statusFrame.status.retweeted_status;
    if (retStatus) {
        XLDetailViewController *detail = [[XLDetailViewController alloc] init];
        
        detail.status = retStatus;
        XLTabBarViewController *main = (XLTabBarViewController *)self.window.rootViewController;
        
        UINavigationController *nav = (UINavigationController *)main.selectedViewController;
        [nav pushViewController:detail animated:YES];
    }
}

-(void)setStatusFrame:(XLBaseStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    XLStatus *status = statusFrame.status.retweeted_status;
    XLUser *user = status.user;
    
    //1.昵称
    self.retNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
    self.retNameLabel.frame = self.statusFrame.retweetNameLebelF;
    
    //2.正文
    self.retContentLabel.text = status.text;
    self.retContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    //3.配图
    if (status.pic_urls.count ) {
        self.retPhotoViews.hidden = NO;
        
        self.retPhotoViews.frame = self.statusFrame.retweetPhotosViewF;
        self.retPhotoViews.photos = status.pic_urls;
    }else{
        self.retPhotoViews.hidden = YES;
    }
    
}


@end
