//
//  BaseViewController.m
//  NetMusic
//
//  Created by xsdlr on 14/12/1.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "BaseViewController.h"
#import "UIButtonMake.h"

@interface BaseViewController ()
- (void) initLayout;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor {
    _navigationBarBackgroundColor = navigationBarBackgroundColor;
    self.navigationController.navigationBar.backgroundColor = _navigationBarBackgroundColor;
}

- (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor {
    _navigationBarTitleColor = navigationBarTitleColor;
    self.navigationController.navigationBar.barTintColor = _navigationBarTitleColor;
}

- (void)initLayout {
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置状态栏字体颜色为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (UIBarButtonItem*) addButtonByImage:(NSString*) imageName selectedImageName:(NSString *) selectedImageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    UIButton *button = [UIButtonMake createWithImage:image
                                       selectedimage:(UIImage *) selectedImage
                                              target:self
                                              action:@selector(leftButtonDealer:)
                                              events:UIControlEventTouchUpInside];
    UIView *subView = [[UIView alloc] initWithFrame:button.frame];
    [subView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView: subView];
    return barButtonItem;
}

- (void)addLeftButtonByImage:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    self.navigationItem.leftBarButtonItem = [self addButtonByImage:imageName selectedImageName:selectedImageName];
}

- (void)addRightButtonByImage:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    self.navigationItem.rightBarButtonItem = [self addButtonByImage:imageName selectedImageName:selectedImageName];
}

- (UIBarButtonItem*) addButtonByTitle:(NSString*) title  {
    UIButton *button = [UIButtonMake createWithTitle:title width:50.0f height:44.0f target:self action:@selector(leftButtonDealer:) events:UIControlEventTouchUpInside];
    UIView *subView = [[UIView alloc] initWithFrame:button.frame];
    [subView addSubview:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:subView];
    return barButtonItem;
}

- (void)addLeftButtonByTitle:(NSString *)title {
    self.navigationItem.leftBarButtonItem = [self addButtonByTitle:title];
}

- (void)addRightButtonByTitle:(NSString *)title {
    self.navigationItem.rightBarButtonItem = [self addButtonByTitle:title];
}

- (void) leftButtonDealer: (id)sender {
    NSLog(@"点击导航栏左按钮");
}

- (void)addTitleViewByTitle:(NSString *)title color:(UIColor *)color {
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];      //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];     //设置文本字体与大小
    titleLabel.textColor = color;                           //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;
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
