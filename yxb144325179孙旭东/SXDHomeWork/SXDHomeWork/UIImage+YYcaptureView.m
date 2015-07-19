//
//  UIImage+UIImage_YYcaptureView.m
//  SXDHomeWork
//
//  Created by  sephiroth on 14/12/12.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "UIImage+YYcaptureView.h"

@implementation UIImage (YYcaptureView)
+(UIImage *)YYcaptureImageWithView:(UIView *)view AndImageView:(UIImageView *)imageView
{
    //.创建bitmap图形上下文
    UIGraphicsBeginImageContext(view.frame.size);
    //2.将要保存的view的layer绘制到bitmap图形上下文中
    
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //3.取出绘制好的图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    //4.返回获取的图片
    return newImage;
}

@end
