//
//  PaintPath.h
//  Project4-Note
//
//  Created by  ws on 11/20/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PaintPath : NSObject
@property (strong,nonatomic) UIColor* color;
@property (assign,nonatomic) CGFloat width;
@property (strong,nonatomic) UIBezierPath* path;

- (instancetype)initWithColor:(UIColor*) color width:(CGFloat) width path:(UIBezierPath*) path;
@end
