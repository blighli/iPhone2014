//
//  TCamera.h
//  Tour
//
//  Created by LFR on 14-7-2.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol Cameraimage
/**
 *  获取照片后的操作
 *
 *  @param image 获取的照片
 */
- (void)useImage:(UIImage*)image;
@end


@interface Camera : UIImagePickerController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong,nonatomic) UIImage* theImage;
@property (strong,nonatomic) NSURL* mediaURL;

/**
 *  拍照
 *
 *  @param currentView 当前正在调用相机的控制器
 */
- (void)takePhoto:(UIViewController*)currentView;

/**
 *  获取相册图片
 *
 *  @param currentView 当前正在调用相机的控制器
 */
- (void)loadPhoto:(UIViewController*)currentView;


@end
