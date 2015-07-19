//
//  XLNewFeatureViewController.m
//  XinLang
//
//  Created by 周舟 on 14-9-30.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLNewFeatureViewController.h"
#import "XLTabBarViewController.h"
#import "XLAccountViewController.h"

#define XLNewfeatureImageCount 3

@interface XLNewFeatureViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation XLNewFeatureViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //1.添加scrollView
    [self addNewScrollView];
    
   
    //2.添加pagecontrol
    
    [self addNewPageControl];
    
}
/**
 *  添加ScrollView
 */

- (void)addNewScrollView
{
    NSLog(@"addNewScrollView");
    
    //1.初始化scrollView
    
    UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView = scrollView;
    //2.添加图片
    [self addImageViewToScrollView];
    
    [self.view addSubview:scrollView];
    
    
    
    
}

- (void)addImageViewToScrollView
{
    //NSLog(@"addImageViewToScrollView");
    
    
    for (int i = 1; i < 4 ; i ++) {
        UIImageView *view = [[UIImageView alloc]init];
        NSString *imageStr = nil;
        if (fourInch) {
            imageStr = [NSString stringWithFormat:@"new_feature_%d-568h",i];
        }else{
            imageStr = [NSString stringWithFormat:@"new_feature_%d",i];
        }
        
        [view setImage:[UIImage imageNamed:imageStr]];
        
        
        
        view.frame = CGRectMake((i - 1) * self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        //NSLog(@"view:%@",view);
        //最后一页图片
        if(i == 3) {
            [view setUserInteractionEnabled:YES];
            [self addButtons:view
             ];
        }
        
        [_scrollView addSubview:view];
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.view.bounds.size.height);
    NSLog(@"%@",_scrollView);
}
- (void)addButtons:(UIImageView *)view
{
    //1.添加开始按钮
    UIButton *button = [[UIButton alloc] init];
    
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"开始微博" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    //2.设置frame
    button.center = CGPointMake(self.view.frame.size.width * 0.5,self.view.frame.size.height * 0.6);
    button.bounds = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    //3.加入父视图
    [view addSubview:button];
    
    //4.checkButton
    UIButton *checkButton = [[UIButton alloc] init];
    checkButton.selected = YES;
    [checkButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkButton.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat centerX = self.view.frame.size.width / 2;
    CGFloat centerY = self.view.frame.size.height / 2;
    checkButton.center = CGPointMake(centerX, centerY);
    [checkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    checkButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkButton addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [view addSubview:checkButton];
}

/**
 *  添加pageControl
 */
- (void)addNewPageControl
{
    //NSLog(@"addNewPageControl");
    
    //1.初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    pageControl.frame = self.view.bounds;
    pageControl.numberOfPages = XLNewfeatureImageCount;
    CGFloat pageCenterX = self.view.frame.size.width * 0.5;
    CGFloat pageCenterY = self.view.frame.size.height - 30;
    
    pageControl.center = CGPointMake(pageCenterX, pageCenterY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = YES;
    
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    //2.设置原点
    pageControl.currentPageIndicatorTintColor = XLColor(253, 98, 42);
    
    pageControl.pageIndicatorTintColor = XLColor(189, 189, 189);
    
    
   
}

/**
 *  点击开始微博
 */
- (void)btnClick
{
    //显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[XLAccountViewController alloc]init];
}

/**
 @brief	分享
 
 @param btn [IN|OUT] 分享按
 */
- (void)checkboxClick:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
}
/**
 *  只要UIScrollView滚动就会调用
 *
 *  @param scrollView
 */

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int) (pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
    
}


@end
