//
//  XLTabBar.h
//  XinLang
//
//  Created by 周舟 on 14-10-1.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLTabBar;

@protocol XLTabBarDelegate <NSObject>
@optional
- (void)tabBar:(XLTabBar *)tabBar didselectedButtonFrom:(int)from to:(int)to;

- (void)tabBarDidClickPlusButton:(XLTabBar *)tabBar;
@end


@interface XLTabBar : UIView
/**
 *  添加tabBaritem
 *
 *  @param item controller的tabBarItem
 */
- (void)addButtonWithItems:(UITabBarItem*)item;

@property(nonatomic, weak) id<XLTabBarDelegate>delegate;
@end
