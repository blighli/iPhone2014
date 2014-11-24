//
//  UIImage+DrawcaptureView.m
//  MyNotes
//
//  Created by tanglie on 14/11/23.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "UIImage+DrawcaptureView.h"

@implementation UIImage (DrawcaptureView)

+ (UIImage *)DrawcaptureImageWithview:(UIView *)view{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}
@end
