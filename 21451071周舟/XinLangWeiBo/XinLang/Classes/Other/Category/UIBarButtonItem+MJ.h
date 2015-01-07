//
//  UIBarButtonItem+MJ.h
//  XinLang
//
//  Created by 周舟 on 14-10-2.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem(MJ)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end
