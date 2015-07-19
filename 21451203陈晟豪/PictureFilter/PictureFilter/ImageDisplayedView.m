//
//  ImageDisplayedView.m
//  PictureFilter
//
//  Created by 陈晟豪 on 15/1/2.
//  Copyright (c) 2015年 Cstlab. All rights reserved.
//

#import "ImageDisplayedView.h"

@interface ImageDisplayedView()

@property (nonatomic) CGPoint firstTouch;
@property (nonatomic) CGPoint lastTouch;

@end

@implementation ImageDisplayedView

- (id)initWithFrameForImage:(UIImage *)image inImageView:(UIImageView *)imageView
{
    self = [super init];
    if(self)
    {
        float hfactor = image.size.width / (imageView.frame.size.width - 20);
        float vfactor = image.size.height / (imageView.frame.size.height - 30);
        
        float factor = fmax(hfactor, vfactor);
        
        float newWidth = image.size.width / factor;
        float newHeight = image.size.height / factor;
        
        float leftOffset = (imageView.frame.size.width - newWidth) / 2;
        float topOffset = (imageView.frame.size.height - newHeight) / 2;
        
        CGRect rect = CGRectMake(leftOffset, topOffset, newWidth, newHeight);
        self.frame = rect;
    }
    return self;
}

@end
