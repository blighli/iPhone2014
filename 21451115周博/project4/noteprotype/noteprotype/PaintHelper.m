//
//  PaintHelper.m
//  noteprotype
//
//  Created by zhou on 14/11/23.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "PaintHelper.h"

@implementation Paint (Helper)

- (UIImage *)getImage
{
    NSURL *pathurl = [NSURL URLWithString:self.paintUrl];
    NSData *data = [NSData dataWithContentsOfURL:pathurl];
    return [UIImage imageWithData:data];
}

@end
