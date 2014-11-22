//
//  PainterLineModel.m
//  paintDemo
//
//  Created by 黄盼青 on 14/11/17.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "PainterLineModel.h"

@implementation PainterLineModel
@synthesize lineColor,linePath,lineWidth;


-(instancetype)initWithPainterInfo:(CGFloat) anWidth withColor:(UIColor *) anColor withPath:(UIBezierPath *) anPath{
    self=[super init];
    if(self) {
        lineWidth=anWidth;
        lineColor=anColor;
        linePath=anPath;
    }
    return self;
}
@end
