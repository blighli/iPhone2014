//
//  UIImage+MJ.m
//  HVeBo
//
//  Created by HJ on 14/12/9.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "UIImage+MJ.h"

@implementation UIImage(MJ)
#pragma mark 加载全屏的图片
// new_feature_1.png
+ (UIImage *)fullscrennImage:(NSString *)imgName
{
    // 2.加载图片
    return [self imageNamed:imgName];
}

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}
@end
