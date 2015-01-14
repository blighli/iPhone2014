//
//  Items.m
//  Homework3
//
//  Created by 李丛笑 on 14/11/9.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Items.h"
@implementation Items

+ (id)itemWithName:(NSString *)name desc:(NSString *)desc
{
    Items *item = [[Items alloc] init];
    item.name = name;
    item.desc = desc;
    
    return item;
}

@end