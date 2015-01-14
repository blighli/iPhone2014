//
//  DrawViewModel.h
//  Homework4
//
//  Created by 李丛笑 on 14/12/23.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawViewModel : NSObject

+ (id)viewModelWithColor:(UIColor *)color Path:(UIBezierPath *)path Width:(CGFloat)width;

@property (strong, nonatomic) UIColor *color;

@property (strong, nonatomic) UIBezierPath *path;

@property (assign, nonatomic) CGFloat width;


@end
