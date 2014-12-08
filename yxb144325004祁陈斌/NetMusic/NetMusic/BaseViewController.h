//
//  BaseViewController.h
//  NetMusic
//
//  Created by xsdlr on 14/12/1.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (weak,nonatomic) UIColor *navigationBarBackgroundColor;
@property (weak,nonatomic) UIColor *navigationBarTitleColor;
/**
 *  添加普通标题栏
 *
 *  @param title 标题名称
 *  @param color 标题颜色
 */
- (void) addTitleViewByTitle: (NSString*) title color:(UIColor*) color;
/**
 *  添加带图片的左侧按钮
 *
 *  @param imageName         图片名
 *  @param selectedImageName 高亮图片名
 */
- (void) addLeftButtonByImage:(NSString*) imageName
            selectedImageName:(NSString *) selectedImageName;
/**
 *  添加带图片的右侧按钮
 *
 *  @param imageName         图片名
 *  @param selectedImageName 高亮图片名
 */
- (void) addRightButtonByImage:(NSString*) imageName
            selectedImageName:(NSString *) selectedImageName;
/**
 *  添加带文字的左侧按钮
 *
 *  @param title 按钮名称
 */
- (void) addLeftButtonByTitle:(NSString*) title;
/**
 *  添加带文字的右侧按钮
 *
 *  @param title 按钮名称
 */
- (void) addRightButtonByTitle:(NSString*) title;
@end