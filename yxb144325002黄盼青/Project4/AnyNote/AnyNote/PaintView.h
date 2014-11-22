//
//  PaintView.h
//  paintDemo
//
//  Created by 黄盼青 on 14/11/17.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PainterLineModel.h"

@interface PaintView : UIView

@property (assign,nonatomic) CGFloat lineWidth;
@property (strong,nonatomic) UIColor *lineColor;

//清空视图
-(void)clearView;

//保存图片
-(UIImage *)saveToImage;

@end
