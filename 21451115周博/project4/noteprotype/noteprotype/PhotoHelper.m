//
//  Image+Helper.m
//  noteprotype
//
//  Created by zhou on 14/11/23.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "PhotoHelper.h"

@implementation Photo (Helper)

- (UIImage *)getImage
{
    
    NSURL *pathurl = [NSURL URLWithString:self.photoUrl];
    NSData *data = [NSData dataWithContentsOfURL:pathurl];
    return [UIImage imageWithData:data];

   
}


@end
