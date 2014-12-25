//
//  Dock.h
//  HVeBo
//
//  Created by HJ on 14/12/14.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dock;

@protocol DockDelegate <NSObject>
@optional
- (void)dock:(Dock *)dock itemSelectedFrom:(NSInteger)from to:(NSInteger)to;
@end



@interface Dock : UIView

// 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title;
// 代理
@property (nonatomic, weak) id<DockDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedIndex;
@end
