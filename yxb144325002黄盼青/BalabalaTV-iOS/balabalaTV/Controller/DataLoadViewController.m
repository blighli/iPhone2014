//
//  DataLoadViewController.m
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/4.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "DataLoadViewController.h"
#import "MainViewController.h"
#import "BBWebService.h"


@interface DataLoadViewController()

@property (strong,nonatomic) UIActivityIndicatorView *indicator;
@property (strong,nonatomic) UILabel *loadLabel;
@property (strong,nonatomic) UIImageView *logoImageView;

@end

@implementation DataLoadViewController


#pragma mark - ViewController Cycle

-(void)viewDidLoad{
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.914 alpha:1.000]];
    
    //初始化Indicator
    _indicator  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.center = self.view.center;
    [_indicator startAnimating];
    [self.view addSubview:_indicator];
    
    
    //初始化状态标签
    CGSize screenSize = self.view.bounds.size;
    _loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, screenSize.height/2-40, screenSize.width, 20)];
    _loadLabel.font = [UIFont systemFontOfSize:11.0f];
    _loadLabel.text = @"正在连接服务器...";
    _loadLabel.textColor = [UIColor blackColor];
    _loadLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_loadLabel];
    
    //初始化LOGO图片
    _logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico-navi-logo"]];
    _logoImageView.center = CGPointMake(screenSize.width/2, screenSize.height/2-60);
    [self.view addSubview:_logoImageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 窗体控制

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //从WEB加载数据
    [self performSelectorInBackground:@selector(getWebData) withObject:nil];
}


-(void)viewWillLayoutSubviews{
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    
    //iOS8以下旋转屏幕时不修改长宽值
    if(sysVersion.floatValue < 8.0f)
    {
        if(UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
        {
            CGSize newScreenSize = CGSizeMake(screenSize.height, screenSize.width);
            screenSize = newScreenSize;
        }
    }
    
    //重新设置旋转屏幕后的位置
    _indicator.center = CGPointMake(screenSize.width/2, screenSize.height/2);
    _loadLabel.frame = CGRectMake(0, screenSize.height/2-40, screenSize.width, 20);
    _logoImageView.center = CGPointMake(screenSize.width/2, screenSize.height/2-60);
}


/**
 *  数据加载失败
 *
 *  @param msg 提示信息
 */
-(void)didDataLoadFailed:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"退出软件" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //退出应用
        exit(0);
    }];
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 *  数据加载完成
 */
-(void)didDataLoadFinish:(NSArray *)array{
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *mainNaviVC = [[UINavigationController alloc]initWithRootViewController:mainVC];
    
    mainNaviVC.navigationBar.barTintColor = [UIColor colorWithRed:0.176 green:0.271 blue:0.525 alpha:1.000];
    mainNaviVC.navigationBar.tintColor = [UIColor whiteColor];
    
    //将数据传递给主界面
    mainVC.tvlistData = [[NSMutableArray alloc]initWithArray:array];
    
    
    //加载主界面
    [self presentViewController:mainNaviVC animated:NO completion:nil];
    
}


#pragma mark - 网络操作

-(void)getWebData{
    
    //连接服务器，并获取节目源数据
    [BBWebService connectToServer:^(NSArray *array) {
        
        //获取电视台Logo
        [BBWebService downloadTVLogo:array withUpdate:YES];
        
        //数据加载完成
        [self performSelectorOnMainThread:@selector(didDataLoadFinish:) withObject:array waitUntilDone:NO];
        
        
    } requestFailed:^(NSString *failReason) {
        
        [self performSelectorOnMainThread:@selector(didDataLoadFailed:) withObject:failReason waitUntilDone:NO];
        
    }];
    
}

@end
