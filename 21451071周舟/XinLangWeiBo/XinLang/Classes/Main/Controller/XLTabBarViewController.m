//
//  XLTabBarViewController.m
//  XinLang
//
//  Created by 周舟 on 14-9-29.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLTabBarViewController.h"
#import "XLTabBar.h"
#import "XlMessageViewController.h"
#import "XLMeViewController.h"
#import "XLConposeViewController.h"
#import "XLDiscoveryViewController.h"
#import "XLHomeViewController.h"
#import "XLNavationViewController.h"
#import "XLUserUnReaderInfo.h"
#import "XLAccount.h"
#import "XLAccountTool.h"
#import "XLHttpTool.h"
#import "MJExtension.h"

#import "XLReweetStatusView.h"


@interface XLTabBarViewController ()<XLTabBarDelegate>

@property (nonatomic, weak) XLTabBar *customTabBar;

@property (nonatomic, weak) XLHomeViewController *home;
@property (nonatomic, weak) XlMessageViewController *message;
@property (nonatomic, weak) XLMeViewController *me;
@property (nonatomic, weak) XLDiscoveryViewController *discovery;
@end

@implementation XLTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    [self steupTabBar];
    
    [self setupAllChildViewControllers];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //NSLog(@"subviewcon:%@",self.childViewControllers);
    
}

/**
 *  定时修改气泡
 */
- (void)checkUnreadCount
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [XLAccountTool account].access_token;
    params[@"uid"] = [NSNumber numberWithLongLong:[XLAccountTool account].uid];
    
    [XLHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id json) {
        
        XLUserUnReaderInfo *unreadInfo = [XLUserUnReaderInfo  objectWithKeyValues:json];
        self.home.tabBarItem.badgeValue      = [NSString stringWithFormat:@"%d",unreadInfo.status];
        self.message.tabBarItem.badgeValue   = [NSString stringWithFormat:@"%d", unreadInfo.messageCount];
        self.discovery.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadInfo.invite];
        self.me.tabBarItem.badgeValue        = [NSString stringWithFormat:@"%d",unreadInfo.follower];
        
    } failure:^(NSError *error) {
        //NSLog(@"获取未读数据失败！");
    }];
    
}

/**
 *  即将出现view
 *
 *  @param animated
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews)
    {
        if ([child isKindOfClass:[UIControl class]]) {
            
            [child removeFromSuperview];
        }
    }
}
/**
 *  初始化tabBar
 */

- (void)steupTabBar
{
    XLTabBar *customTabBar = [[XLTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
    
    
}
/**
 *  初始化所有自控制器
 */
- (void)setupAllChildViewControllers
{
    //1. 首页
   
    
    XLHomeViewController *home = [[XLHomeViewController alloc] init];
   
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    //2。消息
    UIStoryboard *storyboard_message = [UIStoryboard storyboardWithName:@"Message_SB" bundle:nil];
    XlMessageViewController *message = [storyboard_message instantiateViewControllerWithIdentifier:@"messageIdentifier"];
    
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    //3.发现
    
   
    UIStoryboard *storyboard_dis = [UIStoryboard storyboardWithName:@"Discovery" bundle:nil];
    XLDiscoveryViewController *discovery = [storyboard_dis instantiateViewControllerWithIdentifier:@"dicoverIdentifier"];
    
    [self setupChildViewController:discovery title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    self.discovery = discovery;
    
    //4. 我
    UIStoryboard *storyboard_me = [UIStoryboard storyboardWithName:@"XLMeStoryboard" bundle:nil];
    XLMeViewController *me = [storyboard_me instantiateViewControllerWithIdentifier:@"XLMe"];
    
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.me = me;
}


/**
 *  初始化一个自控制器
 *
 *  @param childVc           需要初始化的字控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中时的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //1.设置控制器的属性
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    //2.导航控制器
    XLNavationViewController *nav = [[XLNavationViewController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    //3.添加tabBar内部按钮

    [self.customTabBar addButtonWithItems:childVc.tabBarItem];
    
}

#pragma mark -XLTabBarDelegate代理方法
/**
 *  监听tabBar按钮的变化
 *
 *  @param tabBar
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(XLTabBar *)tabBar didselectedButtonFrom:(int)from to:(int)to
{
    if (from == to  && to == 0) {
        [self.home refresh];
    }else{
        self.selectedIndex = to;
    }
    
}

- (void)tabBarDidClickPlusButton:(XLTabBar *)tabBar
{
    XLConposeViewController *con = [[XLConposeViewController alloc] init];
    XLNavationViewController *nav = [[XLNavationViewController alloc] initWithRootViewController:con];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}








@end
