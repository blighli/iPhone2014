//
//  QuartzView.h
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuartzView : UIView

- (void)addPA:(CGPoint)nPoint;
- (void)addLA;
- (void)clear;
-(void)setLineColor:(NSInteger)color;
-(void)setlineWidth:(NSInteger)width;

@end
