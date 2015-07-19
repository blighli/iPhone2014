//
//  UIBarButtonItem+MJ.m
//  XinLang
//
//  Created by 周舟 on 14-10-2.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "UIBarButtonItem+MJ.h"

@implementation UIBarButtonItem(MJ)

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];

}

@end