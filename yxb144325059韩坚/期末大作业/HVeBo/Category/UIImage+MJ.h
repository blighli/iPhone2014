//
//  UIImage+MJ.h
//  HVeBo
//
//  Created by HJ on 14/12/9.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(MJ)
#pragma mark 加载全屏的图片
+ (UIImage *)fullscrennImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;
@end
