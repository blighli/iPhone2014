//
//  UIImage.m
//  Project3
//
//  Created by  王路尧 on 14/11/24.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import "UIImage.h"

@implementation UIImage (YYcaptureView)
+(UIImage *)YYcaptureImageWithView:(UIView *)view
{
    
    UIGraphicsBeginImageContext(view.frame.size);
   [view.layer renderInContext:UIGraphicsGetCurrentContext()];
   UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
    
   }
@end
