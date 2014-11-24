//
//  ImageUtils.m
//  project4
//
//  Created by xuyouyang on 14/11/24.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils

// 存图片返回路径
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
        // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
    return fullPathToFile;
}

// 根据路径获取图片

@end
