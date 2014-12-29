//
//  UIView+Additions.m
//  HVeBo
//
//  Created by HJ on 14/12/24.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "UIView+Additions.h"


@implementation UIView(Additions)

- (UIViewController *)viewController
{
    UIResponder *next = [self nextResponder];
    do{
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    }while (next != nil);
    return nil;
}

@end
