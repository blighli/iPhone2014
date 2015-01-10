//
//  AppInfoViewController.m
//  美图
//
//  Created by 顾准新 on 14-12-31.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "AppInfoViewController.h"
#import "FBShimmeringView.h"

@interface AppInfoViewController ()
{
    UIImageView         *_wallpaperView;
    FBShimmeringView    *_shimmerAppView;
    UIView              *_contentView;
    UILabel             *_authorLabel;
    UIButton            *_doneButton;
}
@end

@implementation AppInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _wallpaperView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    CGRect shimmeringFrame = self.view.bounds;
//    shimmeringFrame.origin.y = shimmeringFrame.size.height * 0.4;
//    shimmeringFrame.size.height = shimmeringFrame.size.height * 0.6;
//    _shimmerAppView.frame = shimmeringFrame;
    _wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
    _wallpaperView.image = [UIImage imageNamed:@"Wallpaper"];
    [self.view addSubview:_wallpaperView];
    
    _shimmerAppView = [[FBShimmeringView alloc] init];
    _shimmerAppView.shimmering = YES;
    _shimmerAppView.shimmeringBeginFadeDuration = 2;
    _shimmerAppView.shimmeringOpacity = 1;
    [self.view addSubview:_shimmerAppView];
    
    _authorLabel = [[UILabel alloc] initWithFrame:_shimmerAppView.bounds];
    _authorLabel.text = @"Enjoy the view";
    _authorLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50.0];
    _authorLabel.textAlignment = NSTextAlignmentCenter;
    _authorLabel.textColor = [UIColor blackColor];
    _authorLabel.backgroundColor =[UIColor clearColor];
    _shimmerAppView.contentView = _authorLabel;
    
    CGFloat doneW = 50;
    CGFloat doneH = 40;
    CGFloat doneX = self.view.bounds.size.width - doneW -30;
    CGFloat doneY = 0;
    
    _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(doneX, doneY, doneW, doneH)];
    [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [_doneButton setBackgroundColor:[UIColor clearColor]];
    [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_doneButton];
    // Do any additional setup after loading the view.
}

- (void)doneButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect shimmeringFrame = self.view.bounds;
    shimmeringFrame.origin.y = shimmeringFrame.size.height * 0.25;
    shimmeringFrame.size.height = shimmeringFrame.size.height * 0.25;
    _shimmerAppView.frame = shimmeringFrame;
}

@end
