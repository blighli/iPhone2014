//
//  UIImage+DrawcaptureView.h
//  MyNotes
//
//  Created by chencheng on 14/11/21.
//  Copyright (c) 2014年 jikexueyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DrawcaptureView)
//该分类提供一个方法，接收一个view的参数，返回一个view的视图
+ (UIImage *)DrawcaptureImageWithview:(UIView *)view;
@end
