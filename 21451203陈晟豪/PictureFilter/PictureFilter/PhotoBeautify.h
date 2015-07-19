//
//  PhotoBeautify.h
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/22.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBeautify : UIImage

+ (UIImage *)scaleImage:(UIImage *)image;
+ (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size;
+ (UIImage *)setFilter:(UIImage *)image atIndex:(NSInteger)index;
+ (UIImage *)setEffect:(UIImage *)image atIndex:(NSInteger)index byValue:(CGFloat)value;

@end
