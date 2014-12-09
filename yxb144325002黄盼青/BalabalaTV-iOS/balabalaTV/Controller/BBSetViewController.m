//
//  BBSetViewController.m
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/9.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "BBSetViewController.h"
#import "MainViewController.h"

@interface BBSetViewController ()

@property (strong,nonatomic) MainViewController *rootViewController;

@property (strong,nonatomic) UIControl *contentView;

@property (strong,nonatomic) UISwitch *loadLogoSwitch;

@end

@implementation BBSetViewController


static CGFloat CONTENT_WIDTH = 200.0f;
static UIColor *CONTENT_BGCOLOR = nil;

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CONTENT_BGCOLOR = [UIColor colorWithWhite:0.331 alpha:0.900];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isSetDisplay = NO;
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    //初始化内容视图
    _contentView = [[UIControl alloc]initWithFrame:CGRectMake(screenRect.size.width-CONTENT_WIDTH, 0, CONTENT_WIDTH, screenRect.size.height)];
    _contentView.backgroundColor = CONTENT_BGCOLOR;
    [self.view addSubview:_contentView];
    
    //初始化设置内容
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30,70, 100, 50)];
    label.text = @"强制刷新台标";
    label.font = [UIFont boldSystemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    [_contentView addSubview:label];
    
    _loadLogoSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(130, 78, 100, 50)];
    [_contentView addSubview:_loadLogoSwitch];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 视图控制
-(void)showSettingPage:(UIViewController *)rc{
    self.rootViewController = (MainViewController *)rc;
    self.view.frame = rc.view.frame;
    [rc.view addSubview:self.view];
    self.isSetDisplay = YES;
    
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    _contentView.frame = CGRectMake(screenRect.size.width-CONTENT_WIDTH, 0, CONTENT_WIDTH, screenRect.size.height);
    
    __block CGRect contentRect = _contentView.frame;
    contentRect.origin.x+=300;
    _contentView.frame = contentRect;
    
    [UIView animateWithDuration:0.2 animations:^{
        contentRect.origin.x-=300;
        _contentView.frame = contentRect;
        
        
    } completion:^(BOOL finished) {
        
    }];
}


-(void)closeSettingPage{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect contentRect = _contentView.frame;
        contentRect.origin.x+=300;
        _contentView.frame = contentRect;
        
    } completion:^(BOOL finished) {
        self.isSetDisplay = NO;
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

@end
