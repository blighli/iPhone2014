//
//  DrawViewModel.h
//  EverNote
//
//  Created by 陈晓强 on 14/12/1.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DrawViewModel : NSObject

+ (id)viewModelWithPath:(UIBezierPath *)path Width:(CGFloat)width;
@property (strong, nonatomic) UIBezierPath *path;
@property (assign, nonatomic) CGFloat width;

@end
