//
//  XLComposePhotoView.m
//  XinLang
//
//  Created by 周舟 on 14-10-7.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLComposePhotoView.h"

@implementation XLComposePhotoView


- (void)addImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [self addSubview:imageView];
    
}

- (NSArray *)totalImages
{
    NSMutableArray *images = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [images addObject:imageView.image];
        
    }
    return images;
}


- (void)layoutSubviews
{
    int count = self.subviews.count;
    CGFloat imageViewWH = 70;
    int maxCloumns = 4;
    CGFloat margin = (self.frame.size.width - maxCloumns * imageViewWH) / (maxCloumns + 1);
    for(int i = 0;i < count; i ++)
    {
        UIImageView *imageView = self.subviews[i];
        CGFloat imageViewX = margin +(i % maxCloumns) * (imageViewWH + margin);
        CGFloat imageViewY = margin + (i / maxCloumns) * (imageViewWH + margin);
        
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWH, imageViewWH);       
    }
}

@end
