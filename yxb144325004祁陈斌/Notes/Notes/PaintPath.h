//
//  PaintPath.h
//  Notes
//
//  Created by xsdlr on 14/11/18.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PaintPath : NSObject
@property (strong,nonatomic) UIColor* color;
@property (assign,nonatomic) CGFloat width;
@property (strong,nonatomic) UIBezierPath* path;

- (instancetype)initWithColor:(UIColor*) color width:(CGFloat) width path:(UIBezierPath*) path;
@end
