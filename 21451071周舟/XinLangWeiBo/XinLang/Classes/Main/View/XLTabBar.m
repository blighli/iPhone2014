//
//  XLTabBar.m
//  XinLang
//
//  Created by 周舟 on 14-10-1.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLTabBar.h"
#import "XlTabBarButton.h"  


@interface XLTabBar()

@property (nonatomic, weak) UIButton *plusButton;
@property (nonatomic, weak) XlTabBarButton *selectedButton;
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@end



@implementation XLTabBar

-(NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return  _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //"+"添加发微博的按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        [plusButton addTarget:self action:@selector(addNewArticle) forControlEvents:UIControlEventTouchUpInside];
        
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        
        [self addSubview:plusButton];
        
        self.plusButton = plusButton;
    }
    return self;
}
/**
 *  添加按钮
 *
 *  @param item 将要添加的按钮
 */

- (void)addButtonWithItems:(UITabBarItem *)item
{
    //1.创建按钮
    XlTabBarButton *button = [[XlTabBarButton alloc] init];
    [self addSubview:button];
    
    //2.添加到数组中
    [self.tabBarButtons addObject:button];
    button.item = item;
    //3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    //4.默认选中第0 个按钮
    if (self.tabBarButtons.count == 1)
    {
        [self buttonClick:button];
    }
}

/**
 *  XlTabBarButton 点击事件，切换视图控制器
 *
 *  @param button XlTabBarButton
 */
- (void)buttonClick:(XlTabBarButton *)button
{
    //1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didselectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didselectedButtonFrom:self.selectedButton.tag to:button.tag];
       // NSLog(@"buttonClick");
        
    }
    //2.设置按钮的状态
    self.selectedButton .selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
}

/**
 *  编辑新的微博
 */
- (void)addNewArticle
{
    if([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)])
    {
        [self.delegate tabBarDidClickPlusButton:self];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    //调整加好的按钮的位置
     self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    //按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    //NSLog(@"--subviews.count:%d",self.subviews.count);
    
    for (int i = 0; i < self.tabBarButtons.count; i ++) {
        //1.取出按钮
        XlTabBarButton *button = self.tabBarButtons[i];
        //2.设置按钮的frame
        CGFloat buttonX = i * buttonW;
        if (i > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
        //3.
        button.tag = i;
        //NSLog( @"button :%@",button);
    }
    
}

@end
