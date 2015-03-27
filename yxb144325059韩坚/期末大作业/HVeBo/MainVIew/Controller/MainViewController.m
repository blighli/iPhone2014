//
//  MainViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/6.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "Dock.h"
#import "WBNavigationController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "UIBarButtonItem+MJ.h"

@interface MainViewController () <DockDelegate, UINavigationControllerDelegate, HomeDelegate>
{
    BOOL _hidden;
}
@end

@implementation MainViewController

- (void)didSelectedHidenSwitch:(BOOL)hidden
{
    _hidden = hidden;
    _dock.hidden = hidden;
    if (hidden) {
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.selectController.view.frame = frame;
    }else{
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - _dock.frame.size.height);
        self.selectController.view.frame = frame;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化所有的子控制器
    [self addAllChildControllers];
    // 2.初始化DockItems
    [self addDockItems];
}
#pragma mark 初始化所有的子控制器
- (void)addAllChildControllers
{
    // 1.首页
    HomeViewController *home = [[HomeViewController alloc] init];
    WBNavigationController *nav1 = [[WBNavigationController alloc] initWithRootViewController:home];
    // self在，添加的子控制器就存在
    nav1.delegate = self;
    [self addChildViewController:nav1];
    home.delegate = self;
    // 2.消息
    MessageViewController *msg = [[MessageViewController alloc] init];
    WBNavigationController *nav2 = [[WBNavigationController alloc] initWithRootViewController:msg];
    nav2.delegate = self;
    [self addChildViewController:nav2];

    DiscoverViewController *dis = [[DiscoverViewController alloc] init];
    WBNavigationController *nav3 = [[WBNavigationController alloc] initWithRootViewController:dis];
    nav3.delegate = self;
    [self addChildViewController:nav3];
    
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    WBNavigationController *nav4 = [[WBNavigationController alloc] initWithRootViewController:profile];
    nav4.delegate = self;
    [self addChildViewController:nav4];
}
#pragma mark 实现导航控制器代理方法
// 导航控制器即将显示新的控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 1.获得当期导航控制器的根控制器
    UIViewController *root = navigationController.viewControllers[0];
    if (root != viewController && !_hidden) { // 不是根控制器
        // 2.拉长导航控制器的view
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].applicationFrame.size.height+20;
        navigationController.view.frame = frame;
        
        // 3.添加Dock到根控制器的view上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y = root.view.frame.size.height - _dock.frame.size.height;
        if ([root.view isKindOfClass:[UIScrollView class]]) { // 根控制器的view是能滚动
            UIScrollView *scroll = (UIScrollView *)root.view;
            dockFrame.origin.y += scroll.contentOffset.y;
        }
        _dock.frame = dockFrame;
        [root.view addSubview:_dock];
        // 4.添加左上角的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_back.png" highlightedIcon:@"navigationbar_back_highlighted.png" target:self action:@selector(back)];
    }
}
- (void)back
{
    [self.childViewControllers[_dock.selectedIndex] popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root && !_hidden) {
        // 1.让导航控制器view的高度还原
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].applicationFrame.size.height - _dock.frame.size.height+20;
        navigationController.view.frame = frame;
        
        // 2.添加Dock到mainView上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        // 调整dock的y值
        dockFrame.origin.y = self.view.frame.size.height - _dock.frame.size.height;
        _dock.frame = dockFrame;
        [self.view addSubview:_dock];
    }
}
#pragma mark 添加Dock
- (void)addDockItems
{
    // 1.设置Dock的背景图片
    _dock.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background.png"]];
    
    // 2.往Dock里面填充内容
    [_dock addItemWithIcon:@"tabbar_home.png" selectedIcon:@"tabbar_home_selected.png" title:@"首页"];
    
    [_dock addItemWithIcon:@"tabbar_message_center.png" selectedIcon:@"tabbar_message_center_selected.png" title:@"消息"];
    
    [_dock addItemWithIcon:@"tabbar_discover.png" selectedIcon:@"tabbar_discover_selected.png" title:@"广场"];
    
    [_dock addItemWithIcon:@"tabbar_profile.png" selectedIcon:@"tabbar_profile_selected.png" title:@"我"];
    
    //[_dock addItemWithIcon:@"tabbar_more.png" selectedIcon:@"tabbar_more_selected.png"  title:@"更多"];
}

@end
