//
//  PhotoBeautify.m
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/22.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <GPUImage/GPUImage.h>
#import "PhotoBeautify.h"


static const NSArray *filters;
static const NSArray *effects;

@implementation PhotoBeautify

+ (void)initialize
{
    //滤镜效果数组分别是
    //素描，卡通，像素化，同心圆，交叉阴影，色彩丢失，晕影，
    //漩涡，水晶球，色调分离，色彩滤镜，浮雕，像素圆点，点染
    
    filters = @[[[GPUImageSketchFilter alloc] init],
                [[GPUImageSmoothToonFilter alloc] init],
                [[GPUImagePixellateFilter alloc] init],
                [[GPUImagePolarPixellateFilter alloc] init],
                [[GPUImageCrosshatchFilter alloc] init],
                [[GPUImageColorPackingFilter alloc] init],
                [[GPUImageVignetteFilter alloc] init],
                [[GPUImageSwirlFilter alloc] init],
                [[GPUImageGlassSphereFilter alloc] init],
                [[GPUImagePosterizeFilter alloc] init],
                [[GPUImageCGAColorspaceFilter alloc] init],
                [[GPUImageEmbossFilter alloc] init],
                [[GPUImagePolkaDotFilter alloc] init],
                [[GPUImageHalftoneFilter alloc] init]];
    
    
    //对图片的编辑效果
    //亮度，曝光,对比度，饱和度,锐化
    effects = @[[[GPUImageBrightnessFilter alloc] init],
                [[GPUImageExposureFilter alloc] init],
                [[GPUImageContrastFilter alloc] init],
                [[GPUImageSaturationFilter alloc] init],
                [[GPUImageSharpenFilter alloc] init]];
}

+ (UIImage *)scaleImage:(UIImage *)image
{
    //图片剪切,缩至原图的0.1倍
    
    if(image.size.width > 500 || image.size.height > 500)
    {
        UIGraphicsBeginImageContext(CGSizeMake(image.size.width * 0.1,image.size.height *0.1));
        [image drawInRect:CGRectMake(0, 0, image.size.width * 0.1, image.size.height *0.1)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return image;
}

+ (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGFloat originalAspect = original.size.width / original.size.height;
    CGFloat targetAspect = size.width / size.height;
    CGRect targetRect;
    if (originalAspect > targetAspect)
    {
        targetRect.size.width = size.width;
        targetRect.size.height = size.height * targetAspect / originalAspect;
        targetRect.origin.x = 0;
        targetRect.origin.y = (size.height - targetRect.size.height) * 0.5;
    }
    else if (originalAspect < targetAspect)
    {
        targetRect.size.width = size.width * originalAspect / targetAspect;
        targetRect.size.height = size.height;
        targetRect.origin.x = (size.width - targetRect.size.width) * 0.5;
        targetRect.origin.y = 0;
    }
    else
    {
        targetRect = CGRectMake(0, 0, size.width, size.height);
    }
    [original drawInRect:targetRect];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return final;
}

+ (UIImage *)setFilter:(UIImage *)image atIndex:(NSInteger)index
{
    //滤镜效果
    
    //获取图片加载到GPU
    GPUImagePicture *imageSource = [[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    
    //初始化滤镜
    id filter = [filters objectAtIndex:index-100];
    
    //添加滤镜
    [imageSource addTarget:filter];
    
    //开始渲染
    [imageSource processImage];
    
    [filter useNextFrameForImageCapture];
    
    //获取渲染后的图片
    UIImage *nearestNeighborImage = [filter imageFromCurrentFramebuffer];
    
    return nearestNeighborImage;
}

+ (UIImage *)setEffect:(UIImage *)image atIndex:(NSInteger)index byValue:(CGFloat)value
{
    //编辑效果
    
    //获取图片加载到GPU
    GPUImagePicture *imageSource = [[GPUImagePicture alloc] initWithImage:image smoothlyScaleOutput:YES];
    
    //初始化滤镜
    id filter = [effects objectAtIndex:index-120];
    
    if([filter isKindOfClass:[GPUImageBrightnessFilter class]])
    {
        //设置亮度值
        [filter setBrightness:value];
    }
    else if([filter isKindOfClass:[GPUImageExposureFilter class]])
    {
        //设置曝光值
        [filter setExposure:value];
    }
    else if([filter isKindOfClass:[GPUImageContrastFilter class]])
    {
        //设置对比度
        [filter setContrast:value*2];
    }
    else if([filter isKindOfClass:[GPUImageSaturationFilter class]])
    {
        //设置饱和度
        [filter setSaturation:value*2];
    }
    else if([filter isKindOfClass:[GPUImageSharpenFilter class]])
    {
        //设置锐化
        [filter setSharpness:value*20];
    }
    
    //添加滤镜
    [imageSource addTarget:filter];
    
    //开始渲染
    [imageSource processImage];
    
    [filter useNextFrameForImageCapture];
    
    //获取渲染后的图片
    UIImage *nearestNeighborImage = [filter imageFromCurrentFramebuffer];
    
    return nearestNeighborImage;
}
@end