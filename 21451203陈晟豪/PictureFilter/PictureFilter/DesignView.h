//
//  DesignView.h
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/27.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DesignView : NSObject

+ (UIImageView *)initTappedLayerStyle;
+ (void)initTabBarItemSelectedStyle:(UITabBarItem *)tabBarItem withSelectedImage:(NSString *)imageName;
+ (void)initImageViewStyle:(UIImageView *)imageView;
+ (void)initScrollViewStyle:(UIScrollView *)scrollView;
+ (UIButton *)initButtonOnvisualEffectView:(UIButton *)button IndexofButton:(NSInteger)index;

@end
