//
//  UIImage+DrawCaptureView.m
//  MyNotes
//
//  Created by 张榕明 on 14/11/22.
//  Copyright (c) 2014年 张榕明. All rights reserved.
//

#import "UIImage+DrawCaptureView.h"

@implementation UIImage (DrawCaptureView)


+(UIImage *)captureimageview:(UIView *)view
{
    //创建bitmap图形上下文
    UIGraphicsBeginImageContext(view.frame.size);
    //用于将要保存的view的layer绘制到bitmap图像上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //取出绘制好的图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    return  image;
}

@end
