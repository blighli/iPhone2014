//
//  PainterLineModel.h
//  paintDemo
//
//  Created by 黄盼青 on 14/11/17.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PainterLineModel : NSObject

@property (assign,nonatomic) CGFloat lineWidth;//线宽
@property (strong,nonatomic) UIColor *lineColor;//颜色
@property (strong,nonatomic) UIBezierPath *linePath;//路径

-(instancetype)initWithPainterInfo:(CGFloat) anWidth withColor:(UIColor *) anColor withPath:(UIBezierPath *) anPath;

@end
