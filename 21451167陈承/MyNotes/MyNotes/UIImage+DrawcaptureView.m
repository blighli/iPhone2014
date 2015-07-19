//
//  UIImage+DrawcaptureView.m
//  MyNotes
//
//  Created by chencheng on 14/11/15.
//  Copyright (c) 2014年 jikexueyuan. All rights reserved.
//

#import "UIImage+DrawcaptureView.h"

@implementation UIImage (DrawcaptureView)

+ (UIImage *)DrawcaptureImageWithview:(UIView *)view
{
    //1.创建bitmap图形上下文
    UIGraphicsBeginImageContext(view.frame.size);
    //2.将要保存的view的layer绘制到bitmap图形上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //3.取出绘制好的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.返回获取的图片
    return newImage;
}
@end
