//
//  UIImage+UIImage_YYcaptureView.m
//  SXDHomeWork
//
//  Created by  Mac on 14/12/12.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "UIImage+YYcaptureView.h"

@implementation UIImage (YYcaptureView)
+(UIImage *)YYcaptureImageWithView:(UIView *)view AndImageView:(UIImageView *)imageView
{

    UIGraphicsBeginImageContext(view.frame.size);
  
    
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    return newImage;
}

@end
