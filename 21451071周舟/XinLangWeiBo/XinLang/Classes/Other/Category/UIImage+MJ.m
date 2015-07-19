//
//  UIImage+MJ.m
//  XinLang
//
//  Created by 周舟 on 14-10-1.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "UIImage+MJ.h"

@implementation UIImage(MJ)

+(UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
