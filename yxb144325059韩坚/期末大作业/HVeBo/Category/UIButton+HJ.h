//
//  UIButton+hj.h
//  HVeBo
//
//  Created by HJ on 14/12/18.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(HJ)
- (id)initWithButtonIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;
+ (id)itemWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;
@end
