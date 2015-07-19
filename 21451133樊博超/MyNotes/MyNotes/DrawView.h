//
//  DrawView.h
//  MyNotes
//
//  Created by 樊博超 on 14-11-23.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property (nonatomic) CGPoint firstTouch;
@property (nonatomic) CGPoint lastTouch;
@property (strong, nonatomic) UIColor *currentColor;
@property (assign, nonatomic) CGMutablePathRef path;
@property (assign, nonatomic) BOOL isHavePath;
@property (strong, nonatomic) NSMutableArray *pathArray;
-(void)clear;
@end
