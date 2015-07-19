//
//  XLComposePhotoView.h
//  XinLang
//
//  Created by 周舟 on 14-10-7.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLComposePhotoView : UIView
/**
 *  添加一张新的图片
 *
 *  @param image 将要添加的图片
 */
- (void)addImage:(UIImage *)image;

/**
 *  返回内部所有的图片
 *
 *  @return 图片数组
 */
- (NSArray *)totalImages;

@end
