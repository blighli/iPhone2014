//
//  DrawView.h
//  Homework4
//
//  Created by 李丛笑 on 14/12/22.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DrawView : UIView

@property (assign, nonatomic) CGFloat lineWidth;
@property (strong, nonatomic) UIColor *lineColor;

-(void)setColor:(int)colorcount;
-(void)setWidth:(int)widthcount;


@end
