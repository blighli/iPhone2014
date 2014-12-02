//
//  DrawViewModel.m
//  EverNote
//
//  Created by 陈晓强 on 14/12/1.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "DrawViewModel.h"

@implementation DrawViewModel
+ (id)viewModelWithPath:(UIBezierPath *)path Width:(CGFloat)width
{
    DrawViewModel *myViewModel = [[DrawViewModel alloc] init];
    
    myViewModel.path = path;
    myViewModel.width = width;
    return myViewModel;
}

@end
