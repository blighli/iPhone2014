//
//  UIButtonMake.h
//  NetMusic
//
//  Created by xsdlr on 14/12/2.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButtonMake : NSObject
/**
 *  生成普通按钮
 *
 *  @param title  按钮标题
 *  @param width  按钮宽度
 *  @param height 按钮高度
 *  @param target 绑定对象
 *  @param action 执行方法
 *  @param events 触发事件
 *
 *  @return UIButton
 */
+ (UIButton *)createWithTitle:(NSString *)title
                        width:(CGFloat)width
                       height:(CGFloat) height
                       target:(id)target
                       action:(SEL)action
                       events:(UIControlEvents) events;
/**
 *  生成带图片的按钮
 *
 *  @param image         按钮图片
 *  @param selectedImage 高亮图片
 *  @param target        绑定对象
 *  @param action        执行方法
 *  @param events        触发事件
 *
 *  @return UIButton
 */
+ (UIButton*) createWithImage: (UIImage*) image
                selectedimage:(UIImage *)selectedImage
                       target:(id)target
                       action:(SEL)action
                       events:(UIControlEvents) events;
/**
 *  生成带图片的按钮
 *
 *  @param image         按钮图片
 *  @param selectedImage 高亮图片
 *  @param frame         frame大小
 *  @param target        绑定对象
 *  @param action        执行方法
 *  @param events        触发事件
 *
 *  @return <#return value description#>
 */
+ (UIButton *)createWithImage:(UIImage *)image
                selectedimage:(UIImage *)selectedImage
                        frame:(CGRect) frame
                       target:(id)target
                       action:(SEL)action
                       events:(UIControlEvents)events;
@end
